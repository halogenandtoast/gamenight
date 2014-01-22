class Poll
  def initialize(data)
    @data = data
  end

  def result(value)
    results(value).max_by { |choice| choice["votes"].to_i }["value"]
  end

  def results(value)
    data["results"].map do |choice|
      { "value" => choice[value], "votes" => votes_for_choice(choice) }
    end
  end

  private
  attr_reader :data

  def votes_for_choice(choice, type = "Best")
    results = choice['result'] || choice['results'] || {}
    votes = results.find { |votes| votes["value"] == type }
    (votes || {}).fetch("numvotes", 0)
  end
end
