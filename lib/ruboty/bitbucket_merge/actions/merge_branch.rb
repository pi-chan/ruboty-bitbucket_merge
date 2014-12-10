module Ruboty
  module BitbucketMerge
    module Actions
      class MergeBranch < Ruboty::Actions::Base

        def call
          @team = message[:team]
          @repo = message[:repo]
          @source = message[:source]
          @target = message[:target]
          
          @user = ENV["BITBUCKET_USERNAME"]
          @pass = ENV["BITBUCKET_PASSWORD"]
          @emakl = ENV["BITBUCKET_EMAIL"]

          begin
            pr_id, links = create_pull_request
            merge_message = build_merge_message(links["commits"]["href"])
            merge_pull_request(links["merge"]["href"], pr_id, merge_message)
            message.reply("Successfully merged.\n\n" + merge_message)
          rescue
            message.reply("Failed to merge.")
          end
        end

        private

        def create_pull_request
          urlstr = "https://api.bitbucket.org/2.0/repositories/#{@team}/#{@repo}/pullrequests"
          url = URI.parse(urlstr)
          params = {
            "title"=> "Merge #{@source} to #{@target}",
            "description"=> "Merge #{@source} to #{@target}",
            "source"=> {
              "branch"=> {
                "name"=> @source
              },
              "repository"=> {
                "full_name"=> "#{@team}/#{@repo}"
              }
            },
            "destination"=> {
              "branch"=> {
                "name"=> @target
              }
            },
            "close_source_branch"=> false
          }

          req = Net::HTTP::Post.new(url.path, initheader =  {'Content-Type' =>'application/json'})
          req.basic_auth @user, @pass
          req.body = params.to_json
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          
          res = http.start {|http|  http.request(req)}
          hash = JSON.parse(res.body)
          return hash["id"], hash["links"]
        end

        def build_merge_message(href)
          url = URI.parse(href)
          req = Net::HTTP::Get.new(url.path, initheader =  {'Content-Type' =>'application/json'})
          req.basic_auth @user, @pass
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          res = http.start {|http|  http.request(req)}
          JSON.parse(res.body)["values"].map{|h| "- " + h["message"]}.join("\n")
        end

        def merge_pull_request(href, pr_id, merge_message)
          url = URI.parse(href)
          params = {
            "owner" => @team,
            "repo_slug" => @repo,
            "pull_request_id" => pr_id,
            "name" => @user,
            "email" => @email,
            "message" => merge_message
          }

          req = Net::HTTP::Post.new(url.path, initheader =  {'Content-Type' =>'application/json'})
          req.basic_auth @user, @pass
          req.body = params.to_json
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          
          res = http.start {|http|  http.request(req)}
          res.body
        end
        
      end
    end
  end
end
