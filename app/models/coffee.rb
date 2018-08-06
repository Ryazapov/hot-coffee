class Coffee < ApplicationRecord
  enum kind: {
    hot_coffee: "hot_coffee",
    cold_coffee: "cold_coffee",
    coffee_drink: "coffee_drink",
    copyright_coffee: "copyright_coffee"
  }

  belongs_to :coffee_house
  has_one :owner, through: :coffee_house

  validates :name, :kind, :volume, :price, presence: true
  validates :volume, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }

  def self.translated_kinds
    I18n.t("activerecord.attributes.coffee.kinds").invert.to_a
  end
end
