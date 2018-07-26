class CoffeeHouse < ApplicationRecord
  belongs_to :owner, class_name: User

  validates :name, :latitude, :longitude, presence: true
end
