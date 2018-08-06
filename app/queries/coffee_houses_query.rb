class CoffeeHousesQuery
  attr_reader :location, :keywords
  delegate :coordinates, to: :location

  private :location, :coordinates

  def initialize(location, keywords)
    @location = location
    @keywords = keywords
  end

  def all
    keywords.blank? ? nearest_coffee_houses : search_coffee_houses
  end

  def nearest_coffee_houses
    CoffeeHouse.near(coordinates)
  end

  def search_coffee_houses
    CoffeeHouse.search_by_text_fields(keywords)
  end
end
