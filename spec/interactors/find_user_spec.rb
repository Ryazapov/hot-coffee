require "rails_helper"

describe FindUser do
  subject(:interactor_call) { described_class.call(user_params: user_params) }
  let(:found_user) { interactor_call.user }

  let!(:user) { create :user, email: "john.smith@example.com", full_name: "John Smith", providers: [provider] }
  let(:provider) { create :facebook_provider }

  let(:user_params) do
    {
      provider: "Facebook",
      uid: provider.uid,
      info: {
        email: "john.smith@example.com"
      }
    }
  end

  context "when user does not have provider" do
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

  context "when such a user does not exist" do
    let(:user_params) do
      {
        provider: "Facebook",
        uid: "another uid",
        info: {
          email: "another.user@example.com"
        }
      }
    end

    it "not found user" do
      expect(found_user).to be_nil
    end
  end
end