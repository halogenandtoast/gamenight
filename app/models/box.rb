class Box < ActiveRecord::Base
  default_scope { order title: :asc }
  belongs_to :owner, polymorphic: true
  belongs_to :location
  has_many :boxed_games
  has_many :games, through: :boxed_games

  delegate :title,
    :image,
    :min_players,
    :max_players,
    :suggested_players,
    :playing_time, to: :game

  def game
    games.first
  end
end
