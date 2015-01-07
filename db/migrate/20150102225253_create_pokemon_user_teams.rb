class CreatePokemonUserTeams < ActiveRecord::Migration
  def change
    create_table :pokemon_user_teams do |t|
      t.integer :user_team_id
      t.integer :pokemon_id

      t.timestamps
    end
  end
end
