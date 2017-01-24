class EventDateFormatter
  def initialize(group)
    @group = group
  end

  def format
    "#{date_string} #{time_string}"
  end

  private
  attr_reader :group

  def date_string
    if group.next_date.to_date == group.time_zone.today
      "today"
    elsif group.next_date.to_date == group.time_zone.today + 1
      "tomorrow"
    else
      group.next_date.strftime("%B %d")
    end
  end

  def time_string
    group.next_time.strftime("%I:%M %p")
  end
end
