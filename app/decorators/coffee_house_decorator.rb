class CoffeeHouseDecorator < ApplicationDecorator
  delegate :id, :name, :latitude, :longitude, :description
  delegate :full_name, to: :owner, prefix: true

  decorates_association :owner
end
