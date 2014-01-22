class Group < ActiveRecord::Base
  has_many :locations
  has_many :boxes, through: :locations
  has_many :group_memberships
  has_many :members, through: :group_memberships, class_name: "User", source: :user
  has_many :rsvps, -> (group) { where("date = ?", group.next_date.to_date) }
  has_many :attendees, through: :rsvps, source: :user

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

  private

  def next_dates
    locations.map(&:next_date)
  end
end
