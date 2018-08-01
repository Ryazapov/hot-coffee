require "rails_helper"

describe Omniauth::ConfirmUser do
  describe ".call" do
    subject(:interactor_call) { described_class.call(user: user).user }

    let(:user) { create :user, :not_confirmed }

    it { is_expected.to be_confirmed }

    context "when user is confirmed" do
      let(:user) { create :user }

      it { is_expected.to be_confirmed }
    end
  end
end
