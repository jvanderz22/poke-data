class UserUsageData
  attr_reader :user_team, :battles

  def initialize(user_team)
    @user_team = user_team
    @battles = Battle.where(selected_team_id: user_team.id)
    add_battle_data
  end

  def pokemon_usage
    @pokemon_usage ||= new_pokemon_usage
  end

  def lead_usage
    @lead_usage ||= {}
  end

  def team_usage
    @team_usage ||= {}
  end

  private

  def new_pokemon_usage
    @user_team.pokemon.inject({}) do |usage_hash, pokemon|
      usage_hash[pokemon.id] = PokemonUsage.new(pokemon.id)
      usage_hash
    end
  end

  def add_battle_data
    @battles.each do |battle|
      add_battle_to_usage(battle)
      add_leads_to_lead_usage(battle.user_team.lead_pokemon, battle.win)
      add_team_to_team_usage(battle.user_team.used_pokemon, battle.win)
    end
  end

  def add_battle_to_usage(battle)
    battle.user_team.pokemon_teams.each do |pokemon_team|
      add_pokemon_to_pokemon_usage(pokemon_team, battle.win)
    end
  end

  def add_pokemon_to_pokemon_usage(pokemon_team, battle_win)
    if pokemon_team.is_lead?
      pokemon_usage[pokemon_team.pokemon_id].add_lead(battle_win)
    elsif pokemon_team.is_back?
      pokemon_usage[pokemon_team.pokemon_id].add_back(battle_win)
    else
      pokemon_usage[pokemon_team.pokemon_id].add_unused
    end
  end

  def add_leads_to_lead_usage(lead_pokemon, battle_win)
    return unless lead_pokemon_is_valid?(lead_pokemon)
    leads_array = lead_pokemon.map { |pokemon| pokemon.id }
    leads_id = leads_array.sort.hash
    if lead_usage[leads_id]
      lead_usage[leads_id].add_battle(battle_win)
    else
      lead_usage[leads_id] = LeadUsage.new(leads_array)
      lead_usage[leads_id].add_battle(battle_win)
    end
  end

  def add_team_to_team_usage(used_pokemon, battle_win)
    return unless team_is_valid?(used_pokemon)
    used_array = used_pokemon.map { |pokemon| pokemon.id }
    used_id = used_array.sort.hash
    if team_usage[used_id]
      team_usage[used_id].add_battle(battle_win)
    else
      team_usage[used_id] = TeamUsage.new(used_array)
      team_usage[used_id].add_battle(battle_win)
    end
  end

  def lead_pokemon_is_valid?(lead_pokemon)
    lead_pokemon.length == 2
  end

  def team_is_valid?(team)
    team.length == 4
  end
end
