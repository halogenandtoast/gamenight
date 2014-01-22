class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite invitation
    @invitation = invitation
    mail to: @invitation.email
  end
end
