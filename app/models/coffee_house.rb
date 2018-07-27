class CoffeeHouse < ApplicationRecord
  belongs_to :owner, class_name: "User"

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  before_validation :reverse_geocode, if: :geoposition_changed?

  validates :name, :latitude, :longitude, :address, presence: true

  def geoposition_changed?
    new_record? || address_changed? || latitude_changed? || longitude_changed?
  end
end
