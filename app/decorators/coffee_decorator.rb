class CoffeeDecorator < ApplicationDecorator
  delegate :id, :name, :type, :volume, :price, :coffee_house_id
  delegate :name, to: :coffee_house, prefix: true

  decorates_association :coffee_house

  def description
    object.description&.html_safe
  end
end
