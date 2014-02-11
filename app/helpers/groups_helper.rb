module GroupsHelper
  def rsvp_tag(member, group)
    if member.rsvped?(group)
      rsvped_tag(member, group)
    else
      attending_tag("needs-rsvp", "Hasn't RSVP'd")
    end
  end

  def rsvped_tag(member, group)
    if member.attending?(group)
      attending_tag("is-attending", "Attending")
    else
      attending_tag("not-attending", "Can't attend")
    end
  end

  def attending_tag(css_class, title)
    content_tag(:span, class: "attending-tag #{css_class}") { title }
  end
end
