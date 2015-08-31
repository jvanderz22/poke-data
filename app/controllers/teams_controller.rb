class UserTeamsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

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
    user_team = UserTeam.new({
      user_id: team_attrs[:user_id],
      name: team_attrs[:name],
      pokemon: pokemon_objs
    })
    user_team.save!
  end

  def pokemon_objs
    @pokemon_objs ||= teams_attrs[:pokemon].each do |pokemon_string|
      pokemon = Pokemon.find_by_name(pokemon_string)
      raise PokemonNotFound if pokemon.nil?
      pokemon
    end
  end

  def team_attrs
    params.require(:team).permit(:pokemon, :user_id, :name)
  end
end
