class InvitationMailer < ActionMailer::Base
  default from: "Board Game Night <noreply@gamenig.ht>"

  def invite invitation
    @invitation = invitation
    mail to: @invitation.email
  end
end
