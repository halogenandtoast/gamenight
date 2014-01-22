class GameNightMailer < ActionMailer::Base
  default from: 'Board Game Night <noreply@boardgamenight.herokuapp.com>'

  def notification(slacker, group)
    @group = group
    @slacker = slacker
    mail(to: @slacker.email)
  end
end
