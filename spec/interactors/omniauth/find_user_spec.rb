require "rails_helper"

describe Omniauth::FindUser do
  describe ".call" do
    subject(:interactor_call) { described_class.call(auth_data: auth_data) }
    let(:found_user) { interactor_call.user }

    let(:auth_data) do
      {
        provider: "facebook",
        uid: "12345",
        email: "john.smith@example.com"
      }
    end

    context "when user does not have provider" do
      let!(:user) { create :user, email: "john.smith@example.com", full_name: "John Smith" }

      it "finds user by email" do
        expect(found_user.email).to eq("john.smith@example.com")
        expect(found_user.full_name).to eq("John Smith")
      end
    end

    context "when user have provider" do
      let!(:user) { create :user, email: "john.smith@example.com", full_name: "John Smith", providers: [provider] }
      let(:provider) { create :facebook_provider }

      it "finds user by provider" do
        expect(found_user.email).to eq("john.smith@example.com")
        expect(found_user.full_name).to eq("John Smith")
      end
    end

    context "when such user does not exist" do
      let(:auth_data) do
        {
          provider: "facebook",
          uid: "another uid",
          info: {
            email: "another.user@example.com"
          }
        }
      end

      it "does not find user" do
        expect(found_user).to be_nil
      end
    end
  end
end
