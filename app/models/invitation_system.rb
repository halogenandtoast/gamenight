class InvitationSystem
  def invite user, options
    sender = options.fetch(:sender)
    group = options.fetch(:group)
    update_user_status(user)
    invitation = Invitation.create(sender: sender, user: user, group: group)
    InvitationMailer.invite(invitation).deliver
  end

  private

  def update_user_status user
    if user.new_record?
      user.status = 'invited'
      user.save
    end
  end
end
