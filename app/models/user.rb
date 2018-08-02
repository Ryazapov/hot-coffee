class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: Provider::NAMES

  has_many :providers, dependent: :destroy

  validates :full_name, presence: true
end
