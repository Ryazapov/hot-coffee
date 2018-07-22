class AuthenticateUser
  include Interactor

  delegate :user_params, to: context

  def call
    context.user = find_or_create_user
    context.provider = create_provider
  end

  private

  def find_or_create_user
    find_user || create_user
  end

  def find_user
    @find_user ||= FindUser.call(user_params: user_params).user
  end

  def create_user
    @create_user ||= CreateUser.call(user_params: user_params[:info]).user
  end

  def create_provider
    context.user.providers.first_or_create(name: user_params.provider, uid: user_params.uid)
  end
end
