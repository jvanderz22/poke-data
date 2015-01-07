class PokemonUserTeam < ActiveRecord::Base
  belongs_to :user_team
  belongs_to :pokemon
end
