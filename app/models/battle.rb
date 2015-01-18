class Battle < ActiveRecord::Base
  validate :user_team_valid, on: :create
  validate :opponent_team_valid, on: :create
  validate :battle_data_valid

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

  private

  def user_team_valid
    if user_team.pokemons.reject { |pokemon| pokemon.name == ''}.length < 4
      @errors.add :user_team, 'must have at least four pokemon'
      return false
    end
    if user_lead_pokemon.length != 2
      @errors.add :user_team, "must have two lead pokemon"
      return false
    end
    if user_back_pokemon.length != 2
      @errors.add :user_team, "must have selected two pokemon in back"
      return false
    end
    return true
  end

  def opponent_team_valid
    if opponent_team.pokemons.reject { |pokemon| pokemon.name == ''}.length < 4
      @errors.add :opponent_team, 'must have at least four pokemon'
      return false
    end
    if opponent_lead_pokemon.length != 2
      @errors.add :opponent_team, "must have selected two lead pokemon"
      return false
    end
    return true
  end

  def battle_data_valid
    return false unless user_pokemon_remaining_valid?
    return false unless opponent_pokemon_remaining_valid?
    return false unless opponent_rating_valid?
    true
  end

  def opponent_rating_valid?
    return true if opponent_rating.nil?
    if opponent_rating > 3000 || opponent_rating < 0
      @errors.add :opponent_rating, "must be a reasonable number"
    end
  end

  def user_pokemon_remaining_valid?
    if user_pokemon_remaining.nil?
      @errors.add :user_pokemon_remaining, "must be set"
      return false
    else
      if user_pokemon_remaining >= 4 || user_pokemon_remaining < 0
        @errors.add :user_pokemon_remaining, "must be less than or equal to 4"
        return false
      end
    end
    return true
  end

  def opponent_pokemon_remaining_valid?
    if opponent_pokemon_remaining.nil?
      @errors.add :opponent_pokemon_remaining, "must be set"
      return false
    else
      if opponent_pokemon_remaining >= 4 || user_pokemon_remaining < 0
        @errors.add :opponent_pokemon_remaining, "must be less than or equal to 4"
        return false
      end
    end
    return true
  end


  def user_lead_pokemon
    user_team.pokemon_teams.select { |pokemon_team| pokemon_team.is_lead == true }
  end

  def user_back_pokemon
    user_team.pokemon_teams.select { |pokemon_team| pokemon_team.is_back == true }
  end

  def opponent_lead_pokemon
    opponent_team.pokemon_teams.select { |pokemon_team| pokemon_team.is_lead == true }
  end
end
