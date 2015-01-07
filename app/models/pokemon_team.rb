class PokemonTeam < ActiveRecord::Base

  belongs_to :team
  belongs_to :pokemon

  def is_used
    is_lead || is_back
  end

  def pokemon_name=(attr)
    if pokemon = Pokemon.find_by(name: attr)
      self.pokemon = pokemon
    else
      self.pokemon = Pokemon.create({name: attr})
    end
  end
end
