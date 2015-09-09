class UsersController < ApplicationController
  include RepresentsJsonApiResources

  def show
    user = User.find(params[:id])
    represent user
  end
end
