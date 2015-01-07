class AddSelectedTeamToBattles < ActiveRecord::Migration
  def change
    add_column :battles, :selected_team_id, :integer
  end
end
