# GoogleAuthAWSContainerCredentialProvider

[The googleauth gem](https://rubygems.org/gems/googleauth) supports AWS Workload Identity,
but it cannot handle container credentials provided by ECS, CodeBuild and so on, which is
passed via the AWS_CONTAINER_CREDENTIALS_RELATIVE_URI environmental variable.
This gem enables it to use the container credential provider.

## Usage

Adding the following the require statement will patch the googleauth to
make it fetch the container credentials when
`AWS_CONTAINER_CREDENTIALS_RELATIVE_URI` or  `AWS_CONTAINER_CREDENTIALS_FULL_URI`
environmental variable is defined.

```
require 'googleauth_aws_container_credential_provider'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aktsk/googleauth_aws_container_credential_provider.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
