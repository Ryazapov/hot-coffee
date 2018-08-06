class CoffeesController < ApplicationController
  expose_decorated :coffees, :filtered_coffees
  expose_decorated :coffee

  def index
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
    params.permit(query: %i[kind volume_from volume_to price_from price_to]).dig(:query)&.to_h
  end

  def page
    params[:page]
  end

  def authorize_resource!
    authorize! coffee
  end
end
