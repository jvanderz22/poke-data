class CreatePokemonTeams < ActiveRecord::Migration
  def change
    create_table :pokemon_teams do |t|
      t.integer :pokemon_id
      t.integer :team_id

      t.timestamps
    end
  end
end
