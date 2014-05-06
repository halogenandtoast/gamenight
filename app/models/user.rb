class User < ActiveRecord::Base
  has_many :boxes, as: :owner, dependent: :destroy
  has_many :games, through: :boxes
  has_many :group_memberships, dependent: :destroy
  has_many :knows, dependent: :destroy
  has_many :rsvps, dependent: :destroy
  has_many :invitations, dependent: :destroy

  has_many :groups, through: :group_memberships
  has_many :locations, through: :groups

  def add_game game
    games << game
  end

  def owns? box
    box.owner_type == 'User' && box.owner_id == id
  end

  def knows? game
    knows.where(game_id: game.id).exists?
  end

  def rsvped? group
    rsvps.where(group_id: group.id, date: group.next_date.to_date).exists?
  end

  def attending? group
    rsvp = rsvps.find_by(group_id: group.id)
    rsvp && rsvp.date == group.next_date.to_date && rsvp.attending?
  end

  def inspect
    email
  end
end
