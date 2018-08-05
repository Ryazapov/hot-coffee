class PagesController < ApplicationController
  expose_decorated :coffee_houses, :fetch_coffee_houses
  expose :result, :fetch_result

  def home
  end

  private

  def fetch_coffee_houses
    NearestCoffeeHousesQuery.new(current_location).all.limit(25)
  end

  def fetch_result
    CoffeeHouse.search_by_name_or_description(params.dig(:query, :keywords)).decorate
  end
end
