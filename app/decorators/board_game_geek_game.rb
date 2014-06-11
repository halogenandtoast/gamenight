class BoardGameGeekGame < SimpleDelegator

  BoardGameGeekDataParser.public_instance_methods(false).each do |method|
    define_method(method) { data_parser.public_send(method) }
  end

  private

  def data_parser
    @data_parser ||= BoardGameGeekDataParser.new(data)
  end

end
