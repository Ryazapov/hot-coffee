class Omniauth::ConfirmUser
  include Interactor

  delegate :user, to: :context

  def call
    user.confirm unless user.confirmed?
  end
end
