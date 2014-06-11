class BoardGameGeekDataParser

  def initialize(data)
    @data = Maybe(data)
  end

  def image
    data["thumbnail"][0].or_else { "missing.jpg" }
  end

  def min_players
    data["minplayers"][0]["value"].or_else { 0 }
  end

  def max_players
    data["maxplayers"][0]["value"].or_else { 0 }
  end

  def suggested_players
    poll_data.result("suggested_numplayers", "numplayers").to_i
  end

  def playing_time
    data["playingtime"][0]["value"].or_else { 0 }
  end

  def mechanics
    data["link"].
      or_else { [] }.
      select { |link| link["type"] == "boardgamemechanic" }.
      map { |mechanic| mechanic["value"] }
  end

  private
  attr_reader :data

  def poll_data
    @poll_data ||= begin
       data_array = data["poll"].or_else { [] }
       PollData.new(data_array)
     end
  end

end
