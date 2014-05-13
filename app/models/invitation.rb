class Invitation < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :sender, class_name: "User"
  before_create :generate_token

  delegate :email, to: :user

  def to_param
    token
  end

  def complete(user_params)
    if user.status == 'invited'
      user.update(user_params.except(:password).merge(token: token, status: 'active'))
      Monban::PasswordReset.new(user, user_params[:password]).perform
      user.save
    end
    user.groups << group
    destroy
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
    while Invitation.exists?(token: self.token)
      self.token = SecureRandom.urlsafe_base64
    end
  end
end
