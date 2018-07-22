require "rails_helper"

describe AuthenticateUser do
  subject(:interactor_call) { described_class.call(user_params: user_params) }
  let(:authenticated_user) { interactor_call.user }

  let(:user_params) do
    {
      provider: "Facebook",
      uid: "another uid",
      info: {
        name: "John Smith",
        email: "another.user@example.com"
      }
    }
  end

  it { is_expected.to be_a_success }
end
