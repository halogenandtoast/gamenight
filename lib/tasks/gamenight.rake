task :notify => :environment do
  Group.all.includes(:locations, :members).find_each do |group|
    if group.has_next_date?
      slackers = group.members - group.attendees
      slackers.each do |slacker|
        GameNightMailer.notification(slacker, group).deliver
      end
    end
  end
end
