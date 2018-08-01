require "rails_helper"

describe Omniauth::VerifyUser do
  describe ".call" do
    subject(:interactor_call) { described_class.call(auth_data: auth_data) }

    let(:auth_data) do
      {
        provider: "facebook",
        verified: true
      }
    end

    it { is_expected.to be_success }

    context "when user not verified" do
      let(:auth_data) do
        {
          provider: "facebook",
          verified: false
        }
      end

      it "failures with error message" do
        is_expected.to be_failure

        expect(interactor_call.error).to eq("Your facebook account is not verified")
      end
    end
  end
end
