class BattleStatistics

  attr_reader :user_team, :current_user

  def initialize(current_user, user_team)
    @current_user = current_user
    @user_team = user_team
  end

  def battles
    @battles ||= current_user.battles.where(selected_team_id: user_team.id)
  end

  def total_battles
    battles.length
  end

  def wins
    @wins ||= battles.where(win: true)
  end

  def total_wins
    wins.length
  end

  def showdown_battles
    @showdown_battles ||= battles.where(showdown: true)
  end

  def total_showdown_battles
    showdown_battles.length
  end

  def showdown_wins
    @showdown_wins ||= showdown_battles.where(win: true)
  end

  def total_showdown_wins
    showdown_wins.length
  end

  def battle_spot_battles
    @battle_spot_battles ||= battles.where(showdown: false)
  end

  def total_battle_spot_battles
    battle_spot_battles.length
  end

  def battle_spot_wins
    @battle_spot_wins ||= battle_spot_battles.where(win: true)
  end

  def total_battle_spot_wins
    battle_spot_wins.length
  end

  def win_pct
    return 0  if total_battles == 0
    (BigDecimal(total_wins) / total_battles).round(4) * 100
  end

  def showdown_win_pct
    return 0 if total_showdown_battles == 0
    (BigDecimal(total_showdown_wins) / total_showdown_battles).round(4) * 100
  end

  def battle_spot_win_pct
    return 0 if total_battle_spot_battles == 0
    (BigDecimal(total_battle_spot_wins) / total_battle_spot_battles).round(4) * 100
  end

  def avg_showdown_ranking
    @avg_showdown_ranking ||= avg_battles_ranking(showdown_battles)
  end

  def avg_battle_spot_ranking
    @avg_battle_spot_ranking ||= avg_battles_ranking(battle_spot_battles)
  end

  private

  def avg_battles_ranking(battles)
    opponent_ratings = battles.map { |battle| battle.opponent_rating }
    valid_ratings = opponent_ratings.delete_if { |rating| rating.nil? || rating == 0 }
    return 0 if valid_ratings.length == 0
    total = valid_ratings.inject(0) { |sum, ranking| sum + ranking }
    total / valid_ratings.length
  end
end
