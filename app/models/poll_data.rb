class PollData
  def initialize(data)
    @data = data
  end

  def has?(name)
    data.any? { |poll| poll["name"] == name }
  end

  def result(name, value)
    if has?(name)
      poll_for(name).result(value)
    else
      "N/A"
    end
  end

  private
  attr_reader :data

  def poll_for(name)
    poll_data = data.first { |p| p["name"] == name }
    Poll.new(poll_data)
  end
end
