class ApplicationController < ActionController::Base
  include Authentication
  include BulletHelper

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  def request_location
    if Rails.env.development? || Rails.env.test?
      "217.66.24.13"
    else
      request.location.data["ip"]
    end
  end
end
