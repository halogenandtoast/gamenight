class Group < ActiveRecord::Base
  has_many :locations
  has_many :boxes, through: :locations
  has_many :group_memberships
  has_many :members, through: :group_memberships, class_name: "User", source: :user
  has_many :rsvps, -> (group) { where(date: group.next_date.to_date) }
  has_many :votes, -> (group) { where(voted_for: group.next_date.to_date) }
  has_many :voted_games, -> { group("games.id").order("count(games.id) DESC") }, through: :votes, source: :game
  has_many :rsvped_members, through: :attending_rsvps, source: :user
  has_many :attending_rsvps, -> (group) { where("date = ? AND request != 'pass'", group.next_date.to_date) }, { class_name: 'Rsvp' }
  has_many :passing_rsvps, -> (group) { where("date = ? AND request = 'pass'", group.next_date.to_date) }, { class_name: 'Rsvp' }
  has_many :passers, through: :passing_rsvps, source: :user
  has_many :attendees, through: :attending_rsvps, source: :user

  def games
    if has_next_date?
      Game.where(id: available_boxes.select(:game_id))
    else
      Game.none
    end
  end

  def available_boxes
    boxes.
      where(owner_id: rsvped_member_ids, owner_type: "User").
      includes(:game)
  end

  def voted_games
    if has_next_date?
      super
    else
      Game.none
    end
  end

  def users_who_voted_for(game)
    # TODO: revert this when bandaid is not in place
    # votes.to_a.count { |vote| vote.game_id == game.id }

    votes.where(game_id: game.id).map(&:user).uniq
  end

  def attending_members
    if has_next_date?
      attendees
    else
      User.none
    end
  end

  def non_attending_members
    if has_next_date?
      passers
    else
      User.none
    end
  end

  def rsvped_members
    if has_next_date?
      super
    else
      User.none
    end
  end

  def notes
    next_location.notes
  end

  def has_next_date?
    locations.any? { |location| location.has_next_date? }
  end

  def next_date
    next_location.next_date
  end

  def next_time
    next_location.starts_at || NoTime.new
  end

  def next_location
    next_location_with_date || NullLocation.new
  end

  def next_location_with_date
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

  def pending_members
    members - rsvped_members - passers
  end

  private

  def next_dates
    locations.map(&:next_date)
  end
end
