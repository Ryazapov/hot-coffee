class Omniauth::ConnectProvider
  include Interactor

  delegate :user, :auth_data, to: :context

  def call
    context.provider = connect_provider
  end

  private

  def connect_provider
    user.providers.find_or_create_by(provider_params)
  end

  def provider_params
    {
      name: auth_data[:provider],
      uid: auth_data[:uid]
    }
  end
end
