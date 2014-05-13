class Game < ActiveRecord::Base
  def self.alphabetical
    order(title: :asc)
  end

  def image
    data_value("missing.png") { data["thumbnail"][0] }
  end

  def min_players
    data_value { data["minplayers"][0]["value"].to_i }
  end

  def max_players
    data_value { data["maxplayers"][0]["value"].to_i }
  end

  def suggested_players
    poll_data.result("suggested_numplayers", "numplayers").to_i
  end

  def playing_time
    data_value { data["playingtime"][0]["value"].to_i }
  end

  def inspect
    title
  end

  private

  def poll_data
    @poll_data ||= begin
       data_array = data_value([]) { data["poll"] }
       PollData.new(data_array)
     end
  end

  def data_value default = nil, &block
    if retrieved
      block.call
    else
      default
    end
  end
end
