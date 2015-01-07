class AddDetailsToPokemonTeam < ActiveRecord::Migration
  def change
    add_column :pokemon_teams, :is_lead, :boolean
    add_column :pokemon_teams, :is_back, :boolean
  end
end
