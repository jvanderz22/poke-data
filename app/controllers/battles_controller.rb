class BattlesController < ApplicationController
  def create
    Battle.create(battle_params)
    redirect_to root_url
  end

  def user_team
    UserTeam.first
  end

  private

  def battle_params
    {
      selected_team_id: params[:battle][:selected_team_id],
      user_team_id: params[:battle][:user_team_id],
      opponent_team_id: new_opponent_team,
      user_pokemon_remaining: params[:battle][:user_team_id],
      opponent_pokemon_remaining: params[:battle][:opponent_pokemon_remaining],
      win: params[:battle][:win]
    }
  end

  def new_opponent_team
    team = Team.create()
    team_id = team.id
    team.update!({pokemon_teams_attributes: pokemon_team_attrs(team_id)})
    team_id
  end

  def pokemon_team_attrs(team_id)
    pokemon_team = params[:battle][:opponent_team][:pokemon_team]
    Array.new(6).map.with_index do |i, y|
      {
        pokemon_name: pokemon_team["pokemon#{y+1}"],
        is_lead: pokemon_team["pokemon#{y+1}_lead"],
        is_back: pokemon_team["pokemon#{y+1}_back"],
        team_id: team_id
      }
    end
  end
end
