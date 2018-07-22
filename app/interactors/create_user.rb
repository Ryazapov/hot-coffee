class CreateUser
  include Interactor

  delegate :user_params, to: :context

  def call
    context.user = create_user

    context.fail! if create_user.invalid?
  end

  private

  def create_user
    @create_user ||= User.create(create_user_params)
  end

  def create_user_params
    {
      email: user_params[:email],
      password: Devise.friendly_token[0, 20],
      full_name: user_params[:name],
      confirmed_at: Time.current
    }
  end
end
