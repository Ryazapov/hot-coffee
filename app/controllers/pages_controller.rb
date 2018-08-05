class PagesController < ApplicationController
  expose_decorated :coffee_houses, :fetch_coffee_houses
  expose :searched_coffee_houses, :search_coffee_houses

  def home
  end

  private

  def fetch_coffee_houses
    NearestCoffeeHousesQuery.new(current_location).all.limit(25)
  end

  def search_coffee_houses
    CoffeeHouse.search_by_name_or_description(params.dig(:query, :keywords)).decorate
  end
end
