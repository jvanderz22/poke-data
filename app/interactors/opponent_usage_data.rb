class OpponentUsageData
  attr_reader :user_team, :battles

  def initialize(user_team)
    @user_team = user_team
    @battles = Battle.where(selected_team_id: user_team.id)
    add_battle_data
  end

  def pokemon_usage
    @pokemon_usage ||= {}
  end

  private

  def add_battle_data
    @battles.each do |battle|
      add_battle_to_usage(battle)
    end
  end

  def add_battle_to_usage(battle)
    battle.user_team.pokemon_teams.each do |pokemon_team|
      add_pokemon_to_pokemon_usage(pokemon_team, !battle.win)
    end
  end

  def add_pokemon_to_pokemon_usage(pokemon_team, battle_win)
    add_pokemon_to_pokemon_usage_hash(pokemon_team.pokemon)
    if pokemon_team.is_lead?
      pokemon_usage[pokemon_team.pokemon_id].add_lead(battle_win)
    elsif pokemon_team.is_back?
      pokemon_usage[pokemon_team.pokemon_id].add_back(battle_win)
    else
      pokemon_usage[pokemon_team.pokemon_id].add_unused
    end
  end

  def add_pokemon_to_pokemon_usage_hash(pokemon)
    return pokemon_usage[pokemon.id] unless pokemon_usage[pokemon.id].nil?
    pokemon_usage[pokemon.id] = PokemonUsage.new(pokemon.id)
  end
end
