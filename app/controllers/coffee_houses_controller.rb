class CoffeeHousesController < ApplicationController
  expose_decorated :coffee_houses, :fetch_coffee_houses
  expose_decorated :coffee_house
  expose_decorated :coffees, :fetch_coffees

  def index
  end

  def show
  end

  private

  def fetch_coffee_houses
    NearestOrSearchedCoffeeHousesQuery.new(current_location, keywords).all.page(page)
  end

  def fetch_coffees
    coffee_house.coffees.order(created_at: :desc)
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
