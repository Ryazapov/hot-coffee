class Omniauth::VerifyUser
  include Interactor

  delegate :auth_data, to: :context

  def call
    return if auth_data[:verified]

    context.fail!(error: I18n.t("interactors.error.verification", provider: auth_data[:provider]))
  end
end
