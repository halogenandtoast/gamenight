class PasswordResetMailer < ActionMailer::Base
  default from: "Board Game Night <noreply@boardgamenight.herokuapp.com>"

  def change_password(password_reset)
    @password_reset = password_reset
    @user = password_reset.user

    mail(
      to: @user.email,
      subject: 'Change your password'
    )
  end
end
