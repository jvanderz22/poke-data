class UserTeamsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index

  end

  def show
    if user_signed_in?
      user_team = UserTeam.find(params[:id])
      @user_team = user_team
      render json: user_team.to_json(include: :pokemon)
    else
      render json: {pokemon: []}.to_json
    end
  end

  def create
    user_team = create_team
    session[:user_team_id] = user_team.id
    redirect_to controller: 'battles'
  end

  private

  def create_team
    user_team = UserTeam.create(name: params[:user_team][:name], user_id: current_user.id)
    user_team.update!({pokemon_user_teams_attributes: pokemon_team(user_team.id)})
    user_team
  end

  def pokemon_team(team_id)
    pokemon_team = params[:user_team][:pokemon]
    Array.new(6).map.with_index do |i, y|
      {
        pokemon_name: pokemon_team["pokemon#{y+1}"],
        user_team_id: team_id
      }
    end
  end
end
