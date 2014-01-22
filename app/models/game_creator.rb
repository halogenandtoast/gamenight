class GameCreator
  def initialize title
    @title = title
  end

  def create
    Game.create(title: title).tap do |game|
      GameDataJob.new(game).perform
    end
  end

  private
  attr_reader :title
end
