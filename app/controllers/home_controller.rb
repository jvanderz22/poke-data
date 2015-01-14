class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_team = params[:id] ? UserTeam.find(params[:id]) : UserTeam.first
  end

end
