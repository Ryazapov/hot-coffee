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
end
