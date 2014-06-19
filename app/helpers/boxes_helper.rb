module BoxesHelper
  def number_of_players(game)
    if game.fixed_number_of_players?
      pluralize(game.min_players, 'player')
    else
      "#{game.min_players} - #{pluralize(game.max_players, 'player')}"
    end
  end
end
