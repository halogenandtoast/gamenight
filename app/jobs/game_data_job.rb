class GameDataJob
  def initialize game, api_interface = BggApi
    @game = game
    @api_interface = api_interface
  end

  def perform(id = nil)
    game.data = find_game_data(id || game.bgg_id)
    game.retrieved = true
  rescue
    game.retrieved = false
  ensure
    game.save
  end

  private

  def api
    @api ||= @api_interface.new
  end

  def find_game_data(id = nil)
    api.thing(id: id || find_game_id)["item"][0]
  rescue
    raise
  end

  def find_game_id
    find_game["id"]
  end

  def find_game
    results = api.search(query: game.title, type: 'boardgame', exact: 1)
    results["item"].detect { |t| t["name"].find { |n| n["type"] == "primary" }["value"] == game.title }
  rescue
    raise
  end

  private
  attr_reader :game
end
