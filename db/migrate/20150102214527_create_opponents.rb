class CreateOpponents < ActiveRecord::Migration
  def change
    create_table :opponents do |t|
      t.integer :team_id
      t.integer :rating
      t.boolean :showdown

      t.timestamps
    end
  end
end
