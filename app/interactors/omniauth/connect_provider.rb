class Omniauth::ConnectProvider
  include Interactor

  delegate :user, :auth_data, to: :context

  def call
    context.provider = connected_provider
  end

  private

  def connected_provider
    user.providers.first_or_create(provider_params)
  end

  def provider_params
    {
      name: auth_data[:provider],
      uid: auth_data[:uid]
    }
  end
end
