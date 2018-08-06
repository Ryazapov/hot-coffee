class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: Provider::NAMES

  has_many :providers, dependent: :destroy
  has_many :coffee_houses, foreign_key: :owner_id, dependent: :destroy
  has_many :coffees, through: :coffee_houses

  validates :full_name, presence: true
end
