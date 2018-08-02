class Provider < ApplicationRecord
  NAMES = %w[
    facebook
  ].freeze

  belongs_to :user

  validates :name, presence: true, inclusion: { in: NAMES }, uniqueness: { scope: :user_id }
  validates :uid, presence: true, uniqueness: { scope: :name }
end
