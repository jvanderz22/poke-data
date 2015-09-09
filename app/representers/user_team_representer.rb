require 'json_api_representer'

class UserTeamRepresenter < Roar::Decorator
  include JsonApiRepresenter
  include Roar::Coercion

  type 'team'
  alias_method :user_team, :represented

  property :id, type: String
  property :name
  property :user_id
  decorate :pokemon

  private

  def pokemon
    user_team.pokemon.map(&:name)
  end
end
