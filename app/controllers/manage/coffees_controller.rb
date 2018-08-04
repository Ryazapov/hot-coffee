class Manage::CoffeesController < Manage::BaseController
  expose_decorated :coffees, :fetch_coffees
  expose_decorated :coffee, parent: :coffee_house

  def new
  end

  def create
    coffee.save

    respond_with(:manage, coffee_house)
  end

  def show
  end

  def edit
  end

  def update
    coffee.update(coffee_house_params)

    respond_with(:manage, coffee_house)
  end

  def destroy
    coffee_house.destroy

    respond_with(:manage, coffee_house)
  end

  private

  def coffee_params
    params.require(:coffee_house).permit(:name, :type, :volume, :price, :description)
  end

  def fetch_coffees
    coffee_house.coffees.order(created_at: :desc)
  end

  def authorize_resource!
    authorize! coffee_house
  end
end
