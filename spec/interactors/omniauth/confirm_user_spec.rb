require "rails_helper"

describe Omniauth::ConfirmUser do
  subject(:interactor_call) { described_class.call(user: user) }
  let(:confirmed_user) { interactor_call.user }

  let!(:user) { create :user, :not_confirmed }

  it "confirms user" do
    expect(confirmed_user).to be_a_confirmed
  end

  context "when user confimed" do
    let!(:user) { create :user }

    it "confirms user" do
      expect(confirmed_user).to be_a_confirmed
    end
  end
end
