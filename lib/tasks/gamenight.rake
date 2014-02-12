task :notify => :environment do
  Group.all.includes(:locations, :members).find_each do |group|
    if group.has_next_date? && group.next_date.to_date == Date.today
      slackers = group.members - group.rsvped_members
      slackers.each do |slacker|
        GameNightMailer.notification(slacker, group).deliver
      end
    end
  end
end
