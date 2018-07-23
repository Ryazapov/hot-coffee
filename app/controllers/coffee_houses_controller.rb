class CoffeeHousesController < ApplicationController
  expose_decorated :coffee_houses, parent: :current_user
  expose_decorated :coffee_house, parent: :current_user

  def index
  end

  def new
  end

  def create
    coffee_house.save

    respond_with(coffee_house)
  end

  def edit
  end

  def update
    coffee_house.update(coffee_house_params)

    respond_with(coffee_house)
  end

  def destroy
    coffee_house.destroy

    respond_with(coffee_house)
  end

  private

  def coffee_house_params
    params.require(:coffee_house).permit(:name, :latitude, :longitude, :description)
  end
end
