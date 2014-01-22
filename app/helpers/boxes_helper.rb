module BoxesHelper
  def number_of_players(box)
    if box.min_players && box.max_players
      display_for_number_of_players(box.min_players, box.max_players)
    else
      "N/A"
    end
  end

  def display_for_number_of_players(min, max)
    if min == max
      pluralize(min, 'player')
    else
      "#{min} - #{pluralize(max, 'player')}"
    end
  end
end
