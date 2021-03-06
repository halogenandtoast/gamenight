class User < ActiveRecord::Base
  ACTIVE = 'active'

  has_many :boxes, as: :owner, dependent: :destroy
  has_many :games, through: :boxes
  has_many :group_memberships, dependent: :destroy
  has_many :rsvps, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :votes

  has_many :groups, through: :group_memberships
  has_many :locations, through: :groups

  validates :name, presence: true, if: :active?
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, if: :active?

  def add_game game
    boxes.create(title: game.title, game: game)
  end

  def owns? box
    box.owner_type == 'User' && box.owner_id == id
  end

  def rsvped? group
    @rsvped ||= {}
    @rsvped[group] ||= rsvps.where(group_id: group.id, date: group.next_date.to_date).exists?
  end

  def attending? group
    @attending ||= {}
    @attending[group] ||= rsvps.attending.where(group_id: group.id, date: group.next_date.to_date).exists?
  end

  def active?
    status == ACTIVE
  end
end
