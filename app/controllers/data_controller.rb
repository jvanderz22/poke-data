class DataController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show
    @current_team = current_user.user_teams.last
    @usage_data = UserUsageData.new(@current_team)
    prepare_for_display
  end

  def update_display
    id = params[:id]
    @current_team = UserTeam.find(id)
    @usage_data = UserUsageData.new(@current_team)
    prepare_for_display
    respond_to do |format|
      format.js
    end
  end

  #okay there's gotta be a better way to do this...
  def prepare_for_display
    battle_statistics
    user_usage
  end

  def battle_statistics
    @battle_statistics ||= BattleStatistics.new(current_user, @current_team)
  end

  def user_usage
    pokemon_usage
    lead_usage
    team_usage
    valid_leads
    valid_teams
  end

  def pokemon_usage
    @pokemon_usage ||= @usage_data.pokemon_usage.sort_by do |key, pokemon|
      pokemon.used_battles
    end.reverse.map { |key, value| value }
  end

  def lead_usage
    @lead_usage ||= @usage_data.lead_usage.sort_by do |key, lead|
      lead.total_battles
    end.reverse.map { |key, value| value }
  end

  def team_usage
    @team_usage ||= @usage_data.team_usage.sort_by do |key, team|
      team.total_battles
    end.reverse.map { |key, value| value }
  end

  def valid_leads
    @valid_leads ||= lead_usage.inject(0) { |total, lead| total + lead.total_battles }
  end

  def valid_teams
    @valid_teams ||= team_usage.inject(0) { |total, team| total + team.total_battles }
  end
end
