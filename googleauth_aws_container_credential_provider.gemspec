# frozen_string_literal: true

require_relative "lib/googleauth_aws_container_credential_provider/version"

Gem::Specification.new do |spec|
  spec.name = "googleauth_aws_container_credential_provider"
  spec.version = GoogleAuthAWSContainerCredentialProvider::VERSION
  spec.authors = ["Tomoki Sekiyama"]
  spec.email = ["tomoki.sekiyama@aktsk.jp"]

  spec.summary = "Enable googleauth gem to use container credentials provided by ECS, CodeBuild, and so on."
  spec.description = "The googleauth gem supports AWS Workload Identity, but it cannot handle container " \
                     "credentials provided by ECS etc. via AWS_CONTAINER_CREDENTIALS_RELATIVE_URI. " \
                     "This gem enables it to use the container credential provider."
  spec.homepage = "https://github.com/aktsk/googleauth_aws_container_credential_provider"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["source_code_uri"] = "https://github.com/aktsk/googleauth_aws_container_credential_provider"
  spec.metadata["changelog_uri"] = "https://github.com/aktsk/googleauth_aws_container_credential_provider/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "googleauth", ">= 1.5"
end
