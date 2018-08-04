class CoffeeDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper

  delegate :id, :name, :kind, :price, :coffee_house_id
  delegate :name, to: :coffee_house, prefix: true

  decorates_association :coffee_house

  def volume
    "#{object.volume} mL"
  end

  def price
    number_to_currency(object.price)
  end

  def description
    object.description&.html_safe
  end

  def humanized_kind
    I18n.t("activerecord.attributes.coffee.kinds.#{object.kind}")
  end
end
