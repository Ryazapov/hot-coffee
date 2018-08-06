class PagesController < ApplicationController
  def index
  end

  private

  def authorize_resource!
    authorize!(with: NullResourcePolicy)
  end
end
