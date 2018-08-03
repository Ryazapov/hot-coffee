class Manage::BaseController < ApplicationController
  include Authorization

  before_action :authenticate_user!
  before_action :authorize_resource!

  def authorize_resource!
    raise NotImplementedError
  end
end
