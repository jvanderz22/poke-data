class AddNameToUserTeam < ActiveRecord::Migration
  def change
    add_column :user_teams, :name, :string
  end
end
