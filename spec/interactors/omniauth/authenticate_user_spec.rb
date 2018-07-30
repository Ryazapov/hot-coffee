require "rails_helper"

describe Omniauth::AuthenticateUser do
  let(:expected_interactors) do
    [
      Omniauth::PrepareAuthData,
      Omniauth::VerifyUser,
      Omniauth::FindUser,
      Omniauth::CreateUser,
      Omniauth::ConfirmUser,
      Omniauth::ConnectProvider
    ]
  end

  it "organize interactors" do
    expect(described_class.organized).to eq(expected_interactors)
  end

  describe ".call" do
    subject(:interactor_call) { described_class.call(auth_params: auth_params) }
    let(:authenticated_user) { interactor_call.user }
    let(:connected_provider) { interactor_call.provider }

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
      expect(authenticated_user).to be_a_persisted
      expect(authenticated_user.email).to eq("john.smith@example.com")
      expect(authenticated_user.full_name).to eq("John Smith")
      expect(authenticated_user).to be_a_confirmed

      expect(connected_provider).to be_a_persisted
      expect(connected_provider.name).to eq("facebook")
      expect(connected_provider.uid).to eq("12345")
    end

    context "when user with this email already exists" do
      let!(:existed_user) { create :user, email: "john.smith@example.com", full_name: "John Smith" }

      it { expect { interactor_call }.to change(Provider, :count).by(1) }
      it { expect { interactor_call }.not_to change(User, :count) }

      it "found user and creates new provider" do
        expect(authenticated_user).to be_a_persisted
        expect(authenticated_user.email).to eq("john.smith@example.com")
        expect(authenticated_user.full_name).to eq("John Smith")
        expect(authenticated_user).to be_a_confirmed

        expect(connected_provider).to be_a_persisted
        expect(connected_provider.name).to eq("facebook")
        expect(connected_provider.uid).to eq("12345")
      end
    end

    context "when user with this provider already exists" do
      let!(:existed_user) do
        create :user, email: "john.smith@example.com", full_name: "John Smith", providers: [existed_provider]
      end
      let(:existed_provider) { create :facebook_provider, uid: "12345" }

      it { expect { interactor_call }.not_to change(Provider, :count) }
      it { expect { interactor_call }.not_to change(User, :count) }

      it "found user and provider" do
        expect(authenticated_user).to be_a_persisted
        expect(authenticated_user.email).to eq("john.smith@example.com")
        expect(authenticated_user.full_name).to eq("John Smith")
        expect(authenticated_user).to be_a_confirmed

        expect(connected_provider).to be_a_persisted
        expect(connected_provider.name).to eq("facebook")
        expect(connected_provider.uid).to eq("12345")
      end
    end
  end
end
