require "rails_helper"

describe Omniauth::AuthenticateUser do
  subject(:interactor_call) { described_class.call(auth_params: auth_params) }
  let(:user) { interactor_call.user }
  let(:provider) { interactor_call.provider }

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

  it { expect { interactor_call }.to change(User, :count).by(1) }
  it { expect { interactor_call }.to change(Provider, :count).by(1) }

  it "creates a new user with provider" do
    expect(user).to be_a_persisted
    expect(user.email).to eq("john.smith@example.com")
    expect(user.full_name).to eq("John Smith")
    expect(user.password).to be_a_present
    expect(user).to be_a_confirmed

    expect(provider).to be_a_persisted
    expect(provider.name).to eq("facebook")
    expect(provider.uid).to eq("12345")
  end

  context "when user with this email already exists" do
    let!(:user) { create :user, email: "john.smith@example.com", full_name: "John Smith" }

    it { expect { interactor_call }.to change(Provider, :count).by(1) }
    it { expect { interactor_call }.not_to change(User, :count) }

    it "found user and creates new provider" do
      expect(user).to be_a_persisted
      expect(user.email).to eq("john.smith@example.com")
      expect(user.full_name).to eq("John Smith")
      expect(user.password).to be_a_present
      expect(user).to be_a_confirmed

      expect(provider).to be_a_persisted
      expect(provider.name).to eq("facebook")
      expect(provider.uid).to eq("12345")
    end
  end

  context "when user with this provider already exists" do
    let!(:user) { create :user, email: "john.smith@example.com", full_name: "John Smith", providers: [provider] }
    let(:provider) { create :facebook_provider, uid: "12345" }

    it { expect { interactor_call }.not_to change(Provider, :count) }
    it { expect { interactor_call }.not_to change(User, :count) }

    it "found user and provider" do
      expect(user).to be_a_persisted
      expect(user.email).to eq("john.smith@example.com")
      expect(user.full_name).to eq("John Smith")
      expect(user.password).to be_a_present
      expect(user).to be_a_confirmed

      expect(provider).to be_a_persisted
      expect(provider.name).to eq("facebook")
      expect(provider.uid).to eq("12345")
    end
  end
end
