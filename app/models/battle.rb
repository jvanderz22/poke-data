class Battle < ActiveRecord::Base
  belongs_to :user_used_team, foreign_key: "team_id"
  belongs_to :opponent_team, foreign_key: "team_id"
  belongs_to :user_team
end
