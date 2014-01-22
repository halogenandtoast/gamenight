class GameDataJob
  def initialize game, api = BggApi
    @game = game
    @api = api.new
  end

  def perform(id = nil)
    game.data = find_game_data(id || game.bgg_id)
    game.retrieved = true
    game.save
  end

  private

  def find_game_data(id = nil)
    api.thing(id: id || find_game_id)["item"][0]
  end

  def find_game_id
    find_game["id"]
  end

  def find_game
    results = api.search(query: game.title, type: 'boardgame', exact: 1)
    results["item"].detect { |t| t["name"].find { |n| n["type"] == "primary" }["value"] == game.title }
  end

  private
  attr_reader :game, :api
end
