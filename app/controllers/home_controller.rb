class HomeController < ApplicationController
  def index
    @user_team = params[:id] ? UserTeam.find(params[:id]) : UserTeam.first
  end

end
