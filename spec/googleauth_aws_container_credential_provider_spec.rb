# frozen_string_literal: true

RSpec.describe GoogleAuthAWSContainerCredentialProvider do
  def mock_googleauth
    ENV["AWS_DEFAULT_REGION"] = "test"
    ENV["AWS_ACCESS_KEY_ID"] = "test_env_id"
    ENV["AWS_SECRET_ACCESS_KEY"] = "test"
    allow(Google::Auth::ExternalAccount::AwsCredentials).to receive(:retrieve_subject_token!).and_return("original")
  end

  def mock_container_credential_provider
    credentials = '{"AccessKeyId":"test_container_id","SecretAccessKey":"secret","Token":"token"}'
    endpoint = "http://169.254.170.2/test_endpoint"
    response = double(body: credentials, success?: true)
    allow(Faraday.default_connection).to receive(:get).with(endpoint).and_return(response)
  end

  let(:option) { { token_url: "test", credential_source: { "regional_cred_verification_url" => "https://test_sts" } } }
  subject { Google::Auth::ExternalAccount::AwsCredentials.new(option).retrieve_subject_token! }

  it "has a version number" do
    expect(GoogleAuthAWSContainerCredentialProvider::VERSION).not_to be nil
  end

  it "does nothing if ENV is not provided" do
    mock_googleauth

    is_expected.to include "test_env_id"
  end

  it "returns container credentials if AWS_CONTAINER_CREDENTIALS_RELATIVE_URI is set" do
    mock_container_credential_provider

    ENV["AWS_CONTAINER_CREDENTIALS_RELATIVE_URI"] = "/test_endpoint"
    is_expected.to include "test_container_id"
  end

  it "returns container credentials if AWS_CONTAINER_CREDENTIALS_FULL_URI is set" do
    mock_container_credential_provider

    ENV["AWS_CONTAINER_CREDENTIALS_FULL_URI"] = "http://169.254.170.2/test_endpoint"
    is_expected.to include "test_container_id"
  end
end
