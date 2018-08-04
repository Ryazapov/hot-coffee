class Manage::CoffeesController < Manage::BaseController
  expose_decorated :coffee_house
  expose_decorated :coffees, :fetch_coffees
  expose_decorated :coffee, parent: :coffee_house

  def new
  end

  def create
    coffee.save

    respond_with(:manage, coffee_house, coffee)
  end

  def show
  end

  def edit
  end

  def update
    coffee.update(coffee_params)

    respond_with(:manage, coffee_house, coffee)
  end

  def destroy
    coffee.destroy

    respond_with(coffee, location: manage_coffee_house_path(coffee_house))
  end

  private

  def coffee_params
    params.require(:coffee).permit(:name, :kind, :volume, :price, :description)
  end

  def fetch_coffees
    coffee_house.coffees.order(created_at: :desc)
  end

  def authorize_resource!
    authorize! coffee
  end
end
