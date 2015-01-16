class PokemonUsage
  attr_reader :pokemon_id, :total_battles, :lead_battles, :back_battles, :lead_wins, :used_wins

  def initialize(pokemon_id)
    @pokemon_id = pokemon_id
    @total_battles = 0
    @lead_battles = 0
    @back_battles = 0
    @lead_wins = 0
    @used_wins = 0
  end

  def pokemon
    @pokemon ||= Pokemon.find(pokemon_id).name
  end

  def add_lead(win)
    @total_battles += 1
    @lead_battles += 1
    if win
      @lead_wins += 1
      @used_wins += 1
    end
  end

  def add_back(win)
    @total_battles += 1
    @back_battles += 1
    if win
      @used_wins += 1
    end
  end

  def add_unused
    @total_battles += 1
  end

  def used_battles
    back_battles + lead_battles
  end

  def unused_battles
    total_battles - used_battles
  end

  def win_pct
    (BigDecimal(used_wins) / used_battles).round(4) * 100
  end

  def lead_win_pct
    (BigDecimal(lead_wins) / lead_battles).round(4) * 100
  end

  def lead_pct
    (BigDecimal(lead_battles) / used_battles).round(4) * 100
  end

  def used_pct
    (BigDecimal(used_battles) / total_battles).round(4) * 100
  end
end
