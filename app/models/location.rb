class Location < ActiveRecord::Base
  include IceCube

  belongs_to :group
  has_many :boxes
  has_many :games, through: :boxes
  serialize :recurrence_rules, Hash

  def add_game game
    boxes.create(owner: self, location: self, game_ids: [game.id])
  end

  def suggested_games
    @suggested_games ||= suggest_games
  end

  def game_users(game, suggested_games)
    suggested_games[game][:know] + suggested_games[game][:new] + suggested_games[game][:other]
  end

  def suggest_games
    rsvps = group.rsvps.includes(:user).to_a
    return [] unless rsvps.any?
    found = []
    suggested_games = get_suggestions(rsvps)

    perfect = perfect_matches(suggested_games).first
    while perfect
      users = suggested_games[perfect][:know] + suggested_games[perfect][:new]
      found.append([perfect, users])
      rsvps = rsvps.delete_if { |rsvp| users.include? rsvp.user }
      suggested_games = get_suggestions(rsvps)
      perfect = perfect_matches(suggested_games).first
    end

    if rsvps.any?
      sorted = suggested_games.keys.sort_by { |k| suggested_games[k][:know] + suggested_games[k][:new] }
      old_count = -1
      while rsvps.any? && sorted.any? && rsvps.count != old_count
        old_count = rsvps.count
        game = sorted.shift
        users = game_users(game, suggested_games)
        while users.count > game.suggested_players
          if suggested_games[game][:know].count > 1
            suggested_games[game][:know].pop
          else
            suggested_games[game][:new].pop
          end
          users = game_users(game, suggested_games)
        end

        rsvps = rsvps.delete_if { |rsvp| users.include? rsvp.user }

        while users.count < game.suggested_players && rsvps.any?
          another = rsvps.sample
          suggested_games[game][:other].append(another.user)
          users = game_users(game, suggested_games)
          rsvps = rsvps.delete_if { |rsvp| users.include? rsvp.user }
        end
        found.append([game, users])
        suggested_games = get_suggestions(rsvps)
      end
    end
    found
  end

  def get_suggestions(rsvps)
    suggested_games = Hash.new { |hash, key| hash[key] = { know: [], new: [], other: [] } }
    rsvps.each do |rsvp|
      if rsvp.request == 'know'
        games.where(id: rsvp.user.known_game_ids).each do |game|
          suggested_games[game][:know].append(rsvp.user)
        end
      else
        games.where.not(id: rsvp.user.known_game_ids).each do |game|
          suggested_games[game][:new].append(rsvp.user)
        end
      end
    end
    suggested_games
  end

  def perfect_matches(suggested_games)
    suggested_games.keys.select { |k| (suggested_games[k][:know].count + suggested_games[k][:new].count) == k.suggested_players && suggested_games[k][:know].any? }
  end


  def schedule
    unless recurrence_rules.empty?
      @schedule ||= Schedule.new(starts_on).tap do |s|
        s.add_recurrence_rule Rule.from_hash(recurrence_rules)
      end
    end
  end

  def recurrence_rules=(new_rule)
    write_attribute(:recurrence_rules, RecurringSelect.dirty_hash_to_rule(new_rule).to_hash)
  end

  def owns? box
    box.owner_type == 'Location' && box.owner_id == id
  end

  def has_next_date?
    schedule.present?
  end

  def next_date
    schedule.occurs_at?(Date.today) ? Date.today : schedule.next_occurrence
  end
end
