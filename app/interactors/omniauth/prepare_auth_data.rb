class Omniauth::PrepareAuthData
  include Interactor

  REQUIRED_PARAMS = %i[provider uid email name].freeze

  delegate :auth_params, to: :context
  delegate :provider, :uid, to: :auth_params

  def call
    context.auth_data = prepare_auth_data

    context.fail!(error: I18n.t("interactors.error.invalid_auth_data")) unless valid_auth_data?
  end

  private

  def prepare_auth_data
    send("#{provider}_auth_data")
  end

  def valid_auth_data?
    REQUIRED_PARAMS.all? { |key| valid_value?(key) }
  end

  def valid_value?(key)
    context.auth_data[key].to_s.present?
  end

  def facebook_auth_data
    {
      provider: provider,
      uid: uid,
      email: auth_params.dig(:info, :email),
      name: auth_params.dig(:info, :name)
    }
  end

  def google_oauth2_auth_data
    {
      provider: provider,
      uid: uid,
      email: auth_params.dig(:info, :email),
      name: auth_params.dig(:info, :name)
    }
  end
end
