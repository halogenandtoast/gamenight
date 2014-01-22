require 'yaml'

lib_dir = Rails.root.join("lib")
game_yaml = lib_dir.join("all.yaml")

games = YAML.load(File.read(game_yaml))

Game.destroy_all

def game_params(game)
  game.except(:id).merge(bgg_id: game[:id])
end

games.each do |game|
  Game.create(game_params(game))
end
