module ApplicationHelper
  def bgg_link_to(game, &block)
    link_to "http://boardgamegeek.com/boardgame/#{game.bgg_id}", &block
  end
end
