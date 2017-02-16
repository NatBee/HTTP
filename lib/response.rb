require './lib/web_application_server'
require './lib/parser'

class Response
  attr_reader :lines

  def initialize(lines)
    @lines = lines
  end

  def default_path
    parser = Parser.new(lines)
    response = "<pre>\n" + "Verb: #{parser.get_verb}\n" +
      "Path: #{parser.get_path}\n" +
      "Protocol: #{parser.get_protocol}\n" +
      "Host: #{parser.get_host}\n" +
      "Port: #{parser.get_port}\n" +
      "Origin: #{parser.get_host}\n" +
      "Accept: #{parser.get_accept}\n" + "</pre>"
      response
  end

  def datetime_path
    response = Time.now.strftime("%H:%M%p on %A, %B %d, %Y." ) + default_path
  end




end
