class HomeController < ApplicationController
  def index
    
    @user_team = UserTeam.first
  end

  def update_user_team
    binding.pry
  end

end
