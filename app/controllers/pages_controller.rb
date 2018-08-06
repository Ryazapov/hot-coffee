class PagesController < ApplicationController
  expose_decorated :coffee_houses, :nearest_coffee_houses

  def index
  end

  private

  def nearest_coffee_houses
    NearestCoffeeHousesQuery.new(fetch_coffee_houses, current_location).all.limit(25)
  end

  def fetch_coffee_houses
    CoffeeHouse.all
  end

  def authorize_resource!
    authorize! CoffeeHouse
  end
end
