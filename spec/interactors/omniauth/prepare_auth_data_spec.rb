require "rails_helper"

describe Omniauth::PrepareAuthData do
  subject(:interactor_call) { described_class.call(auth_params: auth_params) }
  let(:auth_data) { interactor_call.auth_data }

  let(:auth_params) do
    OmniAuth::AuthHash.new(
      provider: "facebook",
      uid: "12345",
      info: {
        email: "john.smith@example.com",
        name: "John Smith"
      },
      extra: {
        raw_info: {
          verified: true
        }
      }
    )
  end

  context "when omniauth with facebook" do
    let(:expeted_auth_data) do
      {
        provider: "facebook",
        uid: "12345",
        email: "john.smith@example.com",
        name: "John Smith",
        verified: true
      }
    end

    it "prepares facebook auth params" do
      expect(auth_data).to eq(expeted_auth_data)
    end
  end
end
