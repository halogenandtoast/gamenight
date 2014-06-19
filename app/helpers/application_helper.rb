module ApplicationHelper
  def bgg_link_to(game, &block)
    link_to "http://boardgamegeek.com/boardgame/#{game.bgg_id}", &block
  end

  def bgg_game(game)
    yield BoardGameGeekGame.new(game)
  end

  def number_of_players(game)
    if game.max_players.zero?
      "#{game.min_players}"
    else
      "#{game.min_players}-#{game.max_players}"
    end
  end
end
