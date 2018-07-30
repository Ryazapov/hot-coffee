require "rails_helper"

describe Omniauth::CreateUser do
  describe ".call" do
    subject(:interactor_call) { described_class.call(user: user, auth_data: auth_data) }
    let(:user) { nil }
    let(:auth_data) do
      {
        provider: "facebook",
        uid: "12345",
        email: "john.smith@example.com",
        name: "John Smith",
        verified: true
      }
    end

    let(:created_user) { interactor_call.user }

    it { is_expected.to be_a_success }

    it "creates a new user" do
      expect(created_user).to be_a_persisted
      expect(created_user.email).to eq("john.smith@example.com")
      expect(created_user.full_name).to eq("John Smith")
      expect(created_user.password).to be_a_present
    end

    context "when user already exists" do
      let!(:user) { create :user, email: "john.smith@example.com" }

      it { is_expected.to be_a_success }

      it "not creates new user" do
        expect { interactor_call }.not_to change(User, :count)
        expect(created_user).to be_a_present
      end
    end

    context "when auth_data is invalid" do
      let(:auth_data) do
        {
          provider: "facebook",
          uid: "12345",
          name: "John Smith",
          verified: true
        }
      end

      it { is_expected.to be_a_failure }

      it "not creates new user" do
        expect(interactor_call.error).to eq("Can not create a user with the provided data")
        expect { interactor_call }.not_to change(User, :count)
        expect(created_user).to be_a_new_record
      end
    end
  end
end
