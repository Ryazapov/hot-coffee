class CoffeesController < ApplicationController
  expose_decorated :coffees, :filtered_coffees
  expose_decorated :coffee
  expose :filter_coffee_form, -> { FilterCoffeeForm.new(filter_coffee_form_params) }

  def index
    coffees
  end

  def show
  end

  private

  def filtered_coffees
    FilterCoffeesQuery.new(fetch_coffees, filter_params).all.page(page)
  end

  def fetch_coffees
    Coffee.order(created_at: :desc)
  end

  def filter_params
    filter_coffee_form.valid? ? filter_coffee_form_params.to_h : {}
  end

  def filter_coffee_form_params
    params.permit(filter_coffee_form: %i[kind volume_from volume_to price_from price_to]).dig(:filter_coffee_form)
  end

  def page
    params[:page]
  end

  def authorize_resource!
    authorize! coffee
  end
end
