require "rails_helper"

describe Omniauth::ConnectProvider do
  describe ".call" do
    subject(:interactor_call) { described_class.call(user: user, auth_data: auth_data) }
    let(:user) { create :user, email: "john.smith@example.com", full_name: "John Smith" }
    let(:auth_data) do
      {
        provider: "facebook",
        uid: "12345",
        email: "john.smith@example.com",
        name: "John Smith"
      }
    end

    let(:connected_provider) { interactor_call.provider }

    it { expect { interactor_call }.to change(Provider, :count).by(1) }

    it "connects new provider for user" do
      expect(connected_provider).to be_persisted
      expect(connected_provider.name).to eq("facebook")
      expect(connected_provider.uid).to eq("12345")
    end

    context "when user with this provider already exists" do
      let!(:existed_provider) { create :facebook_provider, uid: "12345", user: user }

      it { expect { interactor_call }.not_to change(Provider, :count) }

      it "finds provider" do
        expect(connected_provider).to be_persisted
        expect(connected_provider.name).to eq("facebook")
        expect(connected_provider.uid).to eq("12345")
      end
    end
  end
end
