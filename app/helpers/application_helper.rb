module ApplicationHelper
  def bgg_link_to(game, &block)
    link_to "http://boardgamegeek.com/boardgame/#{game.bgg_id}", &block
  end

  def bgg_game(game)
    yield BoardGameGeekGame.new(game)
  end
end
