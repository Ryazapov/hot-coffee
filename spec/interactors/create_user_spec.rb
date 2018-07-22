require "rails_helper"

describe CreateUser do
  subject(:interactor_call) { described_class.call(user_params: user_params) }
  let(:created_user) { interactor_call.user }

  let(:user_params) do
    {
      name: "John Smith",
      email: "john.smith@example.com"
    }
  end

  it { is_expected.to be_a_success }

  it "creates a new user" do
    expect(created_user).to be_a_persisted
    expect(created_user.email).to eq("john.smith@example.com")
    expect(created_user.full_name).to eq("John Smith")
    expect(created_user.password).to be_a_present
    expect(created_user).to be_a_confirmed
  end

  context "when user with this email already exists" do
    let!(:user) { create :user, email: "john.smith@example.com" }

    it { is_expected.to be_a_failure }

    it "not creates new user" do
      expect { interactor_call }.not_to change(User, :count)
      expect(created_user).to be_a_new_record
    end
  end
end
