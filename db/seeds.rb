require 'yaml'

lib_dir = Rails.root.join("lib")
game_yaml = lib_dir.join("all.yaml")

games = YAML.load(File.read(game_yaml))
def game_params(game)
  game.except(:id).merge(bgg_id: game[:id])
end

games.each do |game|
  Game.find_or_create_by(game_params(game))
end
