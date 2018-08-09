class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include BulletHelper
  include Geolocation

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html
end
