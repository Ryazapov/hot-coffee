class NearestCoffeeHousesQuery
  DISTANCE = 10 # km

  attr_reader :relation, :location
  delegate :coordinates, to: :location

  private :relation, :location, :coordinates

  def initialize(relation, location)
    @relation = relation
    @location = location
  end

  def all
    relation.near(coordinates, DISTANCE, units: :km)
  end
end
