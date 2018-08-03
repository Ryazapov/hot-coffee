class Manage::BaseController < ApplicationController
  include Authorization

  before_action :authenticate_user!
  before_action :authorize_resource!
end
