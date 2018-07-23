class CoffeeHouse < ApplicationRecord
  belongs_to :owner, class_name: User

  validates :name, :latitude, :longitude, presence: true

  geocoded_by :address
  after_validation :geocode
end
