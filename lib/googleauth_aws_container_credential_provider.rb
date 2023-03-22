# frozen_string_literal: true

require "googleauth"
require "time"
require "multi_json"

require_relative "googleauth_aws_container_credential_provider/version"

module GoogleAuthAWSContainerCredentialProvider
  def fetch_security_credentials
    url = if ENV["AWS_CONTAINER_CREDENTIALS_RELATIVE_URI"]
            "http://169.254.170.2#{ENV["AWS_CONTAINER_CREDENTIALS_RELATIVE_URI"]}"
          elsif ENV["AWS_CONTAINER_CREDENTIALS_FULL_URI"]
            ENV["AWS_CONTAINER_CREDENTIALS_FULL_URI"]
          end

    if url
      begin
        response = connection.get url

        raise Faraday::Error, "Status #{r.status}: #{response.body}" unless response.success?

        credentials = MultiJson.load response.body

        return {
          access_key_id: credentials["AccessKeyId"],
          secret_access_key: credentials["SecretAccessKey"],
          session_token: credentials["Token"]
        }
      rescue Faraday::Error => e
        warn "Failed to retrieve container credentials: #{e}"
      end
    end

    super
  end
end

Google::Auth::ExternalAccount::AwsCredentials.prepend(GoogleAuthAWSContainerCredentialProvider)
