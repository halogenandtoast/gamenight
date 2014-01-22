class GameNightMailer < ActionMailer::Base
  default from: 'noreply@boardgamenight.herokuapp.com'

  def notification(slacker, group)
    @group = group
    @slacker = slacker
    mail(to: @slacker.email)
  end
end
