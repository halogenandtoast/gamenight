class Rsvp < ActiveRecord::Base
  ATTENDING = 'new'

  belongs_to :user
  belongs_to :group

  def self.attending
    where(request: ATTENDING)
  end

  def attending?
    request == ATTENDING
  end

  def destroy
    user.votes.where(group: group).destroy_all
    super
  end
end
