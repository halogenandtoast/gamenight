class BoardGameGeekGame < SimpleDelegator

  BoardGameGeekDataParser.public_instance_methods(false).each do |method|
    define_method(method) { data_parser.public_send(method) }
  end

  def fixed_number_of_players?
    max_players.zero? || (max_players == min_players)
  end

  private

  def data_parser
    @data_parser ||= BoardGameGeekDataParser.new(data)
  end

end
