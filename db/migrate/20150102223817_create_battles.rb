class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :user_team_id
      t.integer :opponent_team_id
      t.integer :user_pokemon_remaining
      t.integer :opponent_pokemon_remaining
      t.boolean :win

      t.timestamps
    end
  end
end
