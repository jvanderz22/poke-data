require 'json_api_representer'

class UserRepresenter < Roar::Decorator
  include JsonApiRepresenter
  include Roar::Coercion

  type 'user'
  alias_method :user, :represented

  property :id, type: String
  property :email
end
