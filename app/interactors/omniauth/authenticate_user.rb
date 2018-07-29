class Omniauth::AuthenticateUser
  include Interactor::Organizer

  organize Omniauth::PrepareAuthData, Omniauth::VerifyUser, Omniauth::FindUser, Omniauth::CreateUser,
    Omniauth::ConfirmUser, Omniauth::ConnectProvider
end
