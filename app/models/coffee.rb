class Coffee < ApplicationRecord
  enum type: {
    hot_coffee: "hot_coffee",
    cold_coffee: "cold_coffee",
    coffee_drink: "coffee_drink",
    copyright_coffee: "copyright_coffee"
  }

  belongs_to :coffee_house

  validates :name, :type, :volume, :price, presence: true
  validates :volume, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
end
