class Omniauth::ConfirmUser
  include Interactor

  delegate :user, to: :context

  def call
    user.send_confirmation_instructions unless user.confirmed?
  end
end
