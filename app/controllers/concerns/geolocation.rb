module Geolocation
  extend ActiveSupport::Concern

  included do
    helper_method :current_coordinates
  end

  def current_location
    if client_coordinates_exist?
      Geocoder.search(client_coordinates).first
    else
      request.location
    end
  end

  def current_coordinates
    if client_coordinates_exist?
      client_coordinates
    else
      request.location.coordinates
    end
  end

  private

  def client_coordinates
    [cookies[:latitude], cookies[:longitude]]
  end

  def client_coordinates_exist?
    cookies[:latitude].present? && cookies[:longitude].present?
  end
end
