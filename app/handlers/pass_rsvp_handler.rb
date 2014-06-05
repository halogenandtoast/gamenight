class PassRsvpHandler
  REQUEST_TYPE = 'pass'

  def initialize(rsvp)
    @rsvp = rsvp
  end

  def update
    votes.destroy_all
    rsvp.update(request: REQUEST_TYPE)
  end

  private

  attr_reader :rsvp

  def votes
    rsvp.user.votes.where(group: rsvp.group)
  end
end
