class GameNightMailer < ActionMailer::Base
  default from: 'Board Game Night <noreply@boardgamenight.herokuapp.com>'

  def notification(slacker, group)
    @group = group
    @slacker = slacker
    mail(to: @slacker.email)
  end

  def vote(member, group)
    @group = group
    @member = member
    mail(subject: "Votes needed for the #{@group.title} board game group", to: @member.email)
  end
end
