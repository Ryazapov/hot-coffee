class PagesController < ApplicationController
  expose_decorated :coffee_houses, :fetch_coffee_houses

  def home
  end

  private

  def fetch_coffee_houses
    CoffeeHouse.near(request_location, 1, units: :km).limit(100)
  end
end
