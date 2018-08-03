class ApplicationController < ActionController::Base
  include Authentication
  include BulletHelper

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html
end
