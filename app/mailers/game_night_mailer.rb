class GameNightMailer < ActionMailer::Base
  default from: 'Board Game Night <noreply@gamenig.ht>'

  def notification(slacker, group)
    @group = group
    @slacker = slacker
    mail(to: @slacker.email)
  end

  def vote(member, group)
    @group = group
    @member = member
    mail(to: @member.email)
  end
end
