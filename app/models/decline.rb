class Decline

  def initialize(rsvp)
    @rsvp = rsvp
  end

  def process
    votes.destroy_all
    rsvp.date = nil
    rsvp.save
  end

  private

  attr_reader :rsvp

  def votes
    rsvp.user.votes.where(group: rsvp.group)
  end

end
