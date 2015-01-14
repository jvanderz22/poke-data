class BattlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    puts 'index'
  end

  def create
    Battle.create(battle_params)
    session[:user_team_id] = selected_team_id
    redirect_to controller: 'battles'
  end

  private

  def battle_params
    {
      user_id: current_user.id,
      selected_team_id: selected_team_id,
      user_team_id: new_team('user'),
      opponent_team_id: new_team('opponent'),
      user_pokemon_remaining: params[:battle][:user_pokemon_remaining],
      opponent_pokemon_remaining: params[:battle][:opponent_pokemon_remaining],
      win: params[:battle][:win],
      showdown: params[:battle][:showdown],
      opponent_rating: params[:battle][:opponent_rating]
    }
  end

  def new_team(player)
    team = Team.create()
    team_id = team.id
    team.update!({pokemon_teams_attributes: pokemon_team_attrs(team_id, player)})
    team_id
  end

  def pokemon_team_attrs(team_id, player)
    player_team = "#{player}_team".to_sym
    pokemon_team = params[:battle][player_team][:pokemon_team]
    Array.new(6).map.with_index do |i, y|
      {
        pokemon_name: pokemon_team["pokemon#{y+1}"],
        is_lead: pokemon_team["pokemon#{y+1}_lead"],
        is_back: pokemon_team["pokemon#{y+1}_back"],
        team_id: team_id
      }
    end
  end

  def selected_team_id
    params[:battle][:selected_team_id]
  end
end
