class CreateUserTeams < ActiveRecord::Migration
  def change
    create_table :user_teams do |t|
      t.integer :team_id

      t.timestamps
    end
  end
end
