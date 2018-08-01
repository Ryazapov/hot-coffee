require "rails_helper"

describe Omniauth::ConfirmUser do
  describe ".call" do
    subject(:interactor_call) { described_class.call(user: user).user }

    let(:user) { create :user, :not_confirmed }

    it "sends confirmation instruction" do
      is_expected.not_to be_confirmed

      open_email(user.email)

      expect(current_email).to have_subject("Confirmation instructions")
      expect(current_email).to have_body_text(user.full_name)
    end

    context "when user is confirmed" do
      let(:user) { create :user }

      it { is_expected.to be_confirmed }
    end
  end
end
