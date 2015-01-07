class Pokemon < ActiveRecord::Base
  has_many :pokemon_team
  has_many :teams, through: :pokemon_team
  has_many :pokemon_user_teams
  has_many :user_teams, through: :pokemon_user_teams
end
