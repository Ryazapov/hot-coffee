class Omniauth::AuthenticateUser
  include Interactor::Organizer

  organize Omniauth::PrepareAuthData, Omniauth::FindUser, Omniauth::CreateUser, Omniauth::ConnectProvider
end
