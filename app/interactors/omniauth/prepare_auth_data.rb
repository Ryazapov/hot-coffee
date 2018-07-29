class Omniauth::PrepareAuthData
  include Interactor

  delegate :auth_params, to: :context
  delegate :provider, :uid, to: :auth_params

  def call
    context.auth_data = prepared_auth_data
  end

  private

  def prepared_auth_data
    send("#{provider}_auth_data")
  end

  def facebook_auth_data
    {
      provider: provider,
      uid: uid,
      email: auth_params[:info][:email],
      name: auth_params[:info][:name],
      verified: auth_params[:extra][:raw_info][:verified]
    }
  end
end
