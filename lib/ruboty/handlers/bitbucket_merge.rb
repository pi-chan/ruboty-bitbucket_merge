require "ruboty/bitbucket_merge/actions/merge_branch"

module Ruboty
  module Handlers
    class BitbucketMerge < Base

      env :BITBUCKET_USERNAME, "Bitbucket username"
      env :BITBUCKET_PASSWORD, "Bitbucket password"
      env :BITBUCKET_EMAIL, "Bitbucket email"
      
      on(
        /bb-br-merge (?<source>..+) (?<target>.+) (?<team>.+)\/(?<repo>.+)\z/,
        name: "merge_branch",
        description: "Merge source branch to target branch on specified repository.\nUsage: botname bb-br-merge master release myaccount/myrepo"
      )

      def merge_branch(message)
        Ruboty::BitbucketMerge::Actions::MergeBranch.new(message).call
      end
    end
  end
end
