class FilterCoffeeForm
  include ActiveModel::Model

  attr_accessor :kind, :volume_from, :volume_to, :price_from, :price_to

  validates :volume_from, numericality: { only_integer: true, allow_blank: true }
  validates :volume_to, numericality: { only_integer: true, allow_blank: true }
  validates :price_from, numericality: { allow_blank: true }
  validates :price_to, numericality: { allow_blank: true }
end
