class InvitationCompletor
  def initialize(invitation)
    @invitation = invitation
  end

  def complete(user_params, &block)
    update_user(user_params)
    user.groups << invitation.group
    yield user
    invitation.destroy
  end

  private
  attr_reader :invitation

  def user
    invitation.user
  end

  def invited?
    user.status == 'invited'
  end

  def update_user(user_params)
    if invited?
      user.update(user_params.except(:password).merge(status: 'active'))
      Monban::PasswordReset.new(user, user_params[:password]).perform
      user.save
    end
  end

  def invited_user_params
    {
      status: 'active'
      token: generate_token
    }
  end

  def generate_token
    token = SecureRandom.hex
    while User.where(token: token).exists?
      token = SecureRandom.hex
    end
  end
end
