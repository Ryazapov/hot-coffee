require "rails_helper"

describe Omniauth::PrepareAuthData do
  describe ".call" do
    subject(:interactor_call) { described_class.call(auth_params: auth_params) }
    let(:auth_data) { interactor_call.auth_data }

    context "when auth with facebook" do
      let(:auth_params) do
        OmniAuth::AuthHash.new(
          provider: "facebook",
          uid: "12345",
          info: {
            email: "john.smith@example.com",
            name: "John Smith"
          }
        )
      end

      let(:expeted_auth_data) do
        {
          provider: "facebook",
          uid: "12345",
          email: "john.smith@example.com",
          name: "John Smith"
        }
      end

      it "prepares facebook auth params" do
        is_expected.to be_success

        expect(auth_data).to eq(expeted_auth_data)
      end

      context "when auth params are invalid" do
        let(:auth_params) do
          OmniAuth::AuthHash.new(
            provider: "facebook",
            uid: "12345",
            info: {
              email: "",
              name: ""
            }
          )
        end

        it "does not prepare facebook auth params" do
          is_expected.to be_failure

          expect(interactor_call.error).to eq("Can not create a user with the provided data")
        end
      end

      context "when auth params without required data" do
        let(:auth_params) do
          OmniAuth::AuthHash.new(
            provider: "facebook",
            uid: "12345"
          )
        end

        it "does not prepare facebook auth params" do
          is_expected.to be_failure

          expect(interactor_call.error).to eq("Can not create a user with the provided data")
        end
      end
    end
  end
end
