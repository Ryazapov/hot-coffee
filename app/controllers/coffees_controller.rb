class CoffeesController < ApplicationController
  expose_decorated :coffees, :fetch_coffees
  expose_decorated :coffee

  def index
  end

  def show
  end

  private

  def fetch_coffees
    FilterCoffeesQuery.new(params[:query]).all.page(page)
  end

  def page
    params[:page]
  end

  def authorize_resource!
    authorize! coffee
  end
end
