class BattlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @battle = Battle.new
    if session[:opponent_pokemon].nil?
      generate_empty_session
    end
    @errors = []
    if user_signed_in? && session[:user_team_id].nil?
      @user_team = UserTeam.where(user_id: current_user.id).last
      session[:user_team_id] = @user_team.nil? ? 0 : @user_team.id
    end
  end

  def create
    @battle = Battle.new(battle_params)
    session[:user_team_id] = selected_team_id
    respond_to do |format|
      if @battle.save
        generate_empty_session
        format.html { redirect_to controller: 'battles' }
      else
        @errors = @battle.errors
        session[:battle] = @battle
        save_session
        flash.now[:alert] = 'Battle could not be saved'
        format.html { render :index }
      end
    end
  end

  private

  def generate_empty_session
    session[:opponent_pokemon] = {}
    (1..6).each do |n|
      session[:opponent_pokemon]["pokemon#{n}".to_sym] = ""
      session[:opponent_pokemon]["pokemon#{n}_lead".to_sym] = false
      session[:opponent_pokemon]["pokemon#{n}_back".to_sym] = false
    end
    session[:opponent_pokemon_remaining] = ''
    session[:user_pokemon_remaining] = ''
    session[:win] = false
    session[:showdown] = false
    session[:opponent_rating] = ''
  end

  def save_session
    opponent_team = pokemon_team_attrs('opponent')
    opponent_team.each_with_index do |pokemon, index|
      n = index + 1
      session[:opponent_pokemon]["pokemon#{n}".to_sym] = pokemon[:pokemon_name]
      session[:opponent_pokemon]["pokemon#{n}_lead".to_sym] = pokemon[:is_lead] == '1'
      session[:opponent_pokemon]["pokemon#{n}_back".to_sym] = pokemon[:is_back] == '1'
    end
    session[:opponent_pokemon_remaining] = params['battle']['opponent_pokemon_remaining']
    session[:user_pokemon_remaining] = params['battle']['user_pokemon_remaining']
    session[:win] = params['battle']['win'] == '1'
    session[:showdown] = params['battle']['showdown'] == '1'
    session[:opponent_rating] = params['battle']['opponent_rating']
  end

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
    team.update!({pokemon_teams_attributes: pokemon_team_attrs(player, team_id)})
    team_id
  end

  def pokemon_team_attrs(player, team_id = nil)
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
