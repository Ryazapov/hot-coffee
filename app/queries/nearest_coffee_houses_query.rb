class NearestCoffeeHousesQuery
  DISTANCE = 10 # km

  attr_reader :location
  delegate :coordinates, to: :location

  private :location, :coordinates

  def initialize(location)
    @location = location
  end

  def all
    CoffeeHouse.near(coordinates, DISTANCE, units: :km)
  end
end
