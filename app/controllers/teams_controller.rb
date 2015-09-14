class TeamsController < ApplicationController
  PokemonNotFound = Class.new(StandardError)

  def index
    user_id = params.require(:user_id)
    user_teams = UserTeam.where(user_id: user_id)
    render json: user_teams, each_serializer: TeamSerializer
  end

  def create
    user_team = new_user_team
    if user_team.save!
      render json: user_team, serializer: TeamSerializer
    else
      render json: { errors: ['could not create team'] }.to_json
    end
  rescue PokemonNotFound
    render json: { errors: ['could not create team'] }.to_json
  end

  def destroy
    user_team = UserTeam.find(params[:id])
    if user_team.destroy!
      head :no_content
    else
      render json: { errors: ['could not delete team'] }.to_json
    end
  end

  private

  def new_user_team
    UserTeam.new({
      user_id: team_attrs[:user_id],
      name: team_attrs[:name],
      pokemon: pokemon_objs
    })
  end

  def pokemon_objs
    @pokemon_objs ||= team_attrs[:pokemon].map do |pokemon_string|
      pokemon = Pokemon.find_by_name(pokemon_string)
      raise PokemonNotFound if pokemon.nil?
      pokemon
    end
  end

  def team_attrs
    params.require(:team).permit(:user_id, :name, pokemon: [])
  end
end
