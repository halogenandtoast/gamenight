class GameCreator
  def initialize title
    @title = title
  end

  def create
    Game.create(title: title).tap do |game|
      Delayed::Job.enqueue GameDataJob.new(game)
    end
  end

  private
  attr_reader :title
end
