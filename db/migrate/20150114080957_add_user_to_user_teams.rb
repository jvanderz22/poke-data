class AddUserToUserTeams < ActiveRecord::Migration
  def change
    add_reference :user_teams, :user, index: true
  end
end
