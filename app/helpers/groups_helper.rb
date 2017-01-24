module GroupsHelper
  def vote_link(group, game)
    if group.rsvps.any? { |rsvp| rsvp.user_id == current_user.id } && group.next_date != group.time_zone.today
      if group.votes.any? { |vote| vote.game_id == game.id && vote.user_id == current_user.id }
        link_to 'Unvote', group_vote_path(group, game), method: :delete
      else
        link_to 'Vote', group_vote_path(group, game), method: :patch
      end
    end
  end

  def rsvp_tag(member, group)
    if group.rsvps.any? { |rsvp| rsvp.user_id == member.id }
      rsvped_tag(member, group)
    else
      attending_tag("needs-rsvp", "#{member.name}")
    end
  end

  def next_date_string(group)
    EventDateFormatter.new(group).format
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

  def render_members(group, type)
    members = group.public_send("#{type}_members".to_sym)
    render partial: "member", collection: members, locals: { group: group }
  end
end
