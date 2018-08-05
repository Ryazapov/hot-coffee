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
    CoffeeHouse.near(request_location).page(page)
  end

  def page
    params[:page]
  end
end
