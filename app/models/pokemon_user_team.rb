class PokemonUserTeam < ActiveRecord::Base
  belongs_to :user_team
  belongs_to :pokemon

  def pokemon_name=(attr)
    if pokemon = Pokemon.find_by(name: attr)
      self.pokemon = pokemon
    else
      self.pokemon = Pokemon.create({name: attr})
    end
  end

end
