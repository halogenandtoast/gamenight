class Box < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :location
  belongs_to :game

  delegate :image,
    :min_players,
    :max_players,
    :suggested_players,
    :bgg_id,
    :playing_time, to: :game

  def self.alphabetical
    order(title: :asc)
  end
end
