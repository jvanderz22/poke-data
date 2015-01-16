class LeadUsage
  attr_reader :pokemon_ids, :total_battles, :wins

  def initialize(pokemon_ids)
    @pokemon_ids = pokemon_ids
    @total_battles = 0
    @wins = 0
  end

  def add_battle(win)
    @total_battles += 1
    @wins += 1 if win
  end

  def win_pct
    (BigDecimal(wins) / total_battles).round(4) * 100
  end

  def pokemon
    @pokemon ||= pokemon_ids.map do |pokemon_id|
      Pokemon.find(pokemon_id).name
    end
  end

  def is_valid?
    pokemon_ids.length == 2
  end
end
