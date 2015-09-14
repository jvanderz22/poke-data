class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :pokemon

  def type
    'team'
  end

  def pokemon
    object.pokemon.map(&:name)
  end
end
