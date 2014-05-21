class Group < ActiveRecord::Base
  has_many :locations
  has_many :boxes, through: :locations
  has_many :group_memberships
  has_many :members, through: :group_memberships, class_name: "User", source: :user
  has_many :rsvps, -> (group) { where(date: group.next_date.to_date) }
  has_many :votes, -> (group) { where(voted_for: group.next_date.to_date) }
  has_many :voted_games, -> { group("games.id").order("count(games.id) DESC") }, through: :votes, source: :game
  has_many :rsvped_members, through: :rsvps, source: :user
  has_many :attending_rsvps, -> (group) { where("date = ? AND request != 'pass'", group.next_date.to_date) }, { class_name: 'Rsvp' }
  has_many :passing_rsvps, -> (group) { where("date = ? AND request = 'pass'", group.next_date.to_date) }, { class_name: 'Rsvp' }
  has_many :passers, through: :passing_rsvps, source: :user
  has_many :attendees, through: :attending_rsvps, source: :user
  has_many :games, through: :boxes

  def voted_games
    if has_next_date?
      super
    else
      Game.none
    end
  end

  def notes
    if next_location
      next_location.notes
    end
  end

  def has_next_date?
    locations.any? { |location| location.has_next_date? }
  end

  def next_date
    next_location.next_date
  end

  def next_location
    locations.
      select { |location| location.has_next_date? }.
      min_by { |location| location.next_date }
  end

  def suggested_games
    next_location.suggested_games
  end

  def emails
    members.map(&:email)
  end

  private

  def next_dates
    locations.map(&:next_date)
  end
end
