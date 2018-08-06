class CoffeeHousesController < ApplicationController
  expose_decorated :coffee_houses, :fetch_coffee_houses
  expose_decorated :coffee_house
  expose_decorated :coffees, from: :coffee_house

  def index
  end

  def show
  end

  private

  def fetch_coffee_houses
    NearestOrSearchedCoffeeHousesQuery.new(current_location, keywords).all.page(page)
  end

  def page
    params[:page]
  end

  def keywords
    params.dig(:query, :keywords)
  end

  def authorize_resource!
    authorize! coffee_house
  end
end
