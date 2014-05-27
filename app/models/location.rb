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
    if new_rule != 'null'
      write_attribute(:recurrence_rules, RecurringSelect.dirty_hash_to_rule(new_rule).to_hash)
    end
  end

  def owns? box
    box.owner_type == 'Location' && box.owner_id == id
  end

  def has_next_date?
    has_starts_on_in_future? || schedule.present?
  end

  def has_starts_on_in_future?
    starts_on.present? && starts_on >= Date.current.to_date
  end

  def next_date
    if schedule.present?
      next_scheduled_date
    else
      starts_on
    end
  end

  private

  def next_scheduled_date
    if schedule.occurs_at?(Date.today)
      Date.today
    else
      schedule.next_occurrence
    end
  end
end
