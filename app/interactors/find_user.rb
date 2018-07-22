class FindUser
  include Interactor

  delegate :user_params, to: :context

  def call
    context.user = find_user_by_privider || find_user_by_email
  end

  private

  def find_user_by_privider
    @find_user_by_privider ||= Provider.find_by(name: user_params[:provider], uid: user_params[:uid])&.user
  end

  def find_user_by_email
    @find_user_by_email ||= User.find_by(email: user_params[:info][:email])
  end
end
