class UserTeam < ActiveRecord::Base
  has_many :pokemon_user_teams
  has_many :pokemon, through: :pokemon_user_teams
  accepts_nested_attributes_for :pokemon_user_teams
end
