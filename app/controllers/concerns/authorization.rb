module Authorization
  extend ActiveSupport::Concern
  prepend ActionPolicyDraper

  included do
    before_action :authorize_resource!, unless: :devise_controller?

    verify_authorized unless: :devise_controller?
  end

  def authorize_resource!
    raise NotImplementedError
  end
end
