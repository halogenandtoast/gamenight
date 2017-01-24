require 'bgg-api'

class BggImporter
  def initialize(user)
    @user  = user
    @api = BggApi.new
  end

  def import
    collection.each do |game|
      unless user.boxes.where(game: game).exists?
        user.add_game(game)
      end
    end
  end

  private
  attr_reader :api, :user

  def collection
    user.boxes.where.not(game: existing_games).destroy_all

    existing_games.each do |game|
      unless game.retrieved?
        GameDataJob.new(game).perform
      end
    end
  end

  def game_data
    api.collection({ username: user.bgg_username, subtype: "boardgame", excludesubtype: "boardgameexpansion", own: 1 })["item"]
  end

  def existing_games
    @existing_games ||= Game.where(bgg_id: game_data.map { |datum| datum["objectid"] })
  end
end
