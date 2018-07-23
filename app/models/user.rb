class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :coffee_houses, foreign_key: :owner_id, dependent: :destroy

  validates :full_name, presence: true
end
