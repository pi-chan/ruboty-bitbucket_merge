# Ruboty::BitbucketMerge

An Ruboty Handler + Actions to merge branches on bitbucket via Ruboty..

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## Commands

|Command|Pattern|Description|
|:--|:--|:--|
|[bb-br-merge](#bb-br-merge)|/bb-br-merge (?<source>..+) (?<target>.+) (?<team>.+)/(?<repo>.+)z/|Merge source branch to target branch on specified repository.|

## Usage
### bb-br-merge
* Merge source branch to target branch on specified repository.

~~~
botname bb-br-merge master release myaccount/myrepo
~~~

## ENV

|Name|Description|
|:--|:--|
|BITBUCKET_USERNAME|your Bitbucket username|
|BITBUCKET_PASSWORD|your Bitbucket password|
|BITBUCKET_EMAIL|your Bitbucket e-mail|

## Contributing

1. Fork it ( https://github.com/xoyip/ruboty-bitbucket_merge/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
