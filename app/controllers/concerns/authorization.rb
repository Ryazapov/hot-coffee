module Authorization
  extend ActiveSupport::Concern
  prepend ActionPolicyDraper

  included do
    verify_authorized unless: :devise_controller?
  end

  def authorize_resource!
    raise NotImplementedError
  end
end
