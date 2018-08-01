class Omniauth::PrepareAuthData
  include Interactor

  delegate :auth_params, :auth_data, to: :context
  delegate :provider, :uid, to: :auth_params

  REQUIRED_PARAMS = %i[provider uid email name].freeze

  def call
    context.auth_data = prepare_auth_data

    context.fail!(error: I18n.t("interactors.error.invalid_auth_data")) unless valid_auth_data?
  end

  private

  def prepare_auth_data
    send("#{provider}_auth_data")
  rescue
    context.fail!(error: I18n.t("interactors.error.invalid_auth_data"))
  end

  def valid_auth_data?
    REQUIRED_PARAMS.all? { |key| valid_value?(key) }
  end

  def valid_value?(key)
    auth_data[key].to_s.present?
  end

  def facebook_auth_data
    {
      provider: provider,
      uid: uid,
      email: auth_params[:info][:email],
      name: auth_params[:info][:name]
    }
  end
end
