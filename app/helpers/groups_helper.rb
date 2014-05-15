module GroupsHelper
  def vote_link(group, game)
    if current_user.attending?(group) && group.next_date != Date.today
      if group.votes.where(game: game, user: current_user).exists?
        link_to 'Unvote', group_vote_path(group, game), method: :delete
      else
        link_to 'Vote', group_vote_path(group, game), method: :patch
      end
    end
  end

  def rsvp_tag(member, group)
    if member.rsvped?(group)
      rsvped_tag(member, group)
    else
      attending_tag("needs-rsvp", "#{member.name}")
    end
  end

  def next_date_string(group)
    if group.next_date.to_date == Time.zone.today
      "today"
    elsif group.next_date.to_date == Time.zone.today + 1
      "tomorrow"
    else
      group.next_date.strftime("%B %d")
    end
  end

  def rsvped_tag(member, group)
    if member.attending?(group)
      attending_tag("is-attending", "#{member.name} ✓")
    else
      attending_tag("not-attending", "#{member.name} X")
    end
  end

  def attending_tag(css_class, title)
    content_tag(:span, class: "attending-tag #{css_class}") { title }
  end

  def attending_members(group)
    group.members.select { |member| group.rsvps.where(user: member, request: 'new').exists? }
  end

  def non_attending_members(group)
    group.members.select { |member| group.rsvps.where(user: member, request: 'pass').exists? }
  end

  def pending_members(group)
    group.members.select { |member| !group.rsvps.where(user: member).exists? }
  end
end
