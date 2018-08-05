class Manage::CoffeeHousesController < Manage::BaseController
  expose_decorated :coffee_houses, :fetch_coffee_houses
  expose_decorated :coffee_house, parent: :current_user
  expose_decorated :coffees, from: :coffee_house

  def index
  end

  def new
  end

  def create
    coffee_house.save

    respond_with(:manage, coffee_house)
  end

  def show
  end

  def edit
  end

  def update
    coffee_house.update(coffee_house_params)

    respond_with(:manage, coffee_house)
  end

  def destroy
    coffee_house.destroy

    respond_with(:manage, coffee_house)
  end

  private

  def coffee_house_params
    params.require(:coffee_house).permit(:name, :latitude, :longitude, :description)
  end

  def fetch_coffee_houses
    current_user.coffee_houses.order(created_at: :desc)
  end

  def authorize_resource!
    authorize! coffee_house
  end
end
