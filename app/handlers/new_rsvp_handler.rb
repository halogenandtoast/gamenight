class NewRsvpHandler
  REQUEST_TYPE = 'new'

  def initialize(rsvp)
    @rsvp = rsvp
  end

  def update
    rsvp.update(request: REQUEST_TYPE)
  end

  private

  attr_reader :rsvp
end
