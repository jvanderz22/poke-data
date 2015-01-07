class Team < ActiveRecord::Base
  has_many :pokemon_teams
  has_many :pokemons, through: :pokemon_teams
  accepts_nested_attributes_for :pokemon_teams

  def lead_pokemon
   pokemon_teams.inject([]) do |pokemon, pokemon_team|
    pokemon << pokemon_team.pokemon if pokemon_team.is_lead
    pokemon
   end
  end

  def back_pokemon
    pokemon_teams.inject([]) do |pokemon, pokemon_team|
      pokemon << pokemon_team.pokemon if pokemon_team.is_back
      pokemon
    end
  end

  def used_pokemon
     pokemon_teams.inject([]) do |pokemon, pokemon_team|
      pokemon << pokemon_team.pokemon if pokemon_team.is_used
      pokemon
    end
  end

  def unused_pokemon
    pokemon_teams.inject([]) do |pokemon, pokemon_team|
      pokemon << pokemon_team.pokemon unless pokemon_team.is_used
      pokemon
    end
  end
end
