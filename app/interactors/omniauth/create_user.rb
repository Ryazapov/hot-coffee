class Omniauth::CreateUser
  include Interactor

  delegate :auth_data, to: :context
  delegate :user, to: :context, allow_nil: true

  def call
    return if user

    context.user = created_user

    context.fail!(error: I18n.t("interactors.error.invalid_auth_data")) if created_user.invalid?
  end

  private

  def created_user
    @create_user ||= User.create(user_params)
  end

  def user_params
    {
      email: auth_data[:email],
      password: Devise.friendly_token[0, 20],
      full_name: auth_data[:name]
    }
  end
end
