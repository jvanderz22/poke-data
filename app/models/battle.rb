class Battle < ActiveRecord::Base
  belongs_to :user_used_team, foreign_key: "team_id"
  belongs_to :opponent_team, foreign_key: "team_id"
  belongs_to :user_team

  def user_team
    Team.find(user_team_id)
  end

  def opponent_team
    Team.find(opponent_team_id)
  end

  def selected_team
    UserTeam.find(selected_team_id)
  end

end
