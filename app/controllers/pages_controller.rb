class PagesController < ApplicationController
  expose_decorated :coffee_houses, :fetch_coffee_houses

  def index
  end

  private

  def fetch_coffee_houses
    NearestCoffeeHousesQuery.new(current_location).all.limit(25)
  end

  def authorize_resource!
    authorize! with: PagePolicy
  end
end
