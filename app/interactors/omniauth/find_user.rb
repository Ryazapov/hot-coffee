class Omniauth::FindUser
  include Interactor

  delegate :auth_data, to: :context

  def call
    context.user = find_user_by_provider || find_user_by_email
  end

  private

  def find_user_by_provider
    @find_user_by_provider ||= Provider.find_by(name: auth_data[:provider], uid: auth_data[:uid])&.user
  end

  def find_user_by_email
    @find_user_by_email ||= User.find_by(email: auth_data[:email])
  end
end
