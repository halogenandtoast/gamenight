class InvitationMailer < ActionMailer::Base
  default from: "Board Game Night <noreply@boardgamenight.herokuapp.com>"

  def invite invitation
    @invitation = invitation
    mail to: @invitation.email
  end
end
