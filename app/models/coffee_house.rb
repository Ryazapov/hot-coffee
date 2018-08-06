class CoffeeHouse < ApplicationRecord
  include PgSearch

  belongs_to :owner, class_name: "User"

  has_many :coffees, dependent: :destroy

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  before_validation :reverse_geocode, if: :geoposition_changed?

  validates :name, :latitude, :longitude, :address, presence: true

  pg_search_scope :search_by_text_fields,
    against: %i[name description],
    associated_against: {
      coffees: %i[name description]
    },
    using: { tsearch: { prefix: true } }

  def geoposition_changed?
    new_record? || address_changed? || latitude_changed? || longitude_changed?
  end
end
