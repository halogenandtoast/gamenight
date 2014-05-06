class Location < ActiveRecord::Base
  include IceCube

  belongs_to :group
  has_many :boxes
  has_many :games, through: :boxes
  serialize :recurrence_rules, Hash

  def add_game game
    boxes.create(owner: self, title: game.title, game: game)
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
