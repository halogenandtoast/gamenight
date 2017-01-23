class NullLocation
  def notes
    ""
  end

  def next_date
    Date.today
  end

  def next_time
    NoTime.new
  end

  def suggested_games
    []
  end
end
