module Geolocation
  extend ActiveSupport::Concern

  included do
    helper_method :client_coordinates
  end

  def current_location
    if client_coordinates_exists?
      Geocoder.search(client_coordinates).first
    else
      request.location
    end
  end

  def client_coordinates
    [cookies[:latitude], cookies[:longitude]]
  end

  private

  def client_coordinates_exists?
    cookies[:latitude].present? && cookies[:longitude].present?
  end
end
