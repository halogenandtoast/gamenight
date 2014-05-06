class Box < ActiveRecord::Base
  default_scope { order title: :asc }
  belongs_to :owner, polymorphic: true
  belongs_to :location
  belongs_to :game

  delegate :title,
    :image,
    :min_players,
    :max_players,
    :suggested_players,
    :playing_time, to: :game
end
