class UserTeamsController < ApplicationController
  def index
    binding.pry
  end
  def show
    user_team = UserTeam.find(params[:id])
    @user_team = user_team
    render json: user_team.to_json(include: :pokemon)
  end

  def update_team
    binding.pry
   @user_team = UserTeam.find(params[:id])
  end
end
