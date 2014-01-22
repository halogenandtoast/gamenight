class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def attending?
    request != 'pass'
  end
end
