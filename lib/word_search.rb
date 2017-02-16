require './lib/web_application_server'
require './lib/parser'

class WordSearch
  attr_reader :lines

  def initialize(lines)
    @lines = lines
  end

  def word_search
    parser = Parser.new(lines)
    dictionary = File.read("/usr/share/dict/words").split("\n")
    if dictionary.include?(parser.get_input)
      response = "#{parser.get_input.upcase} is a known word."
    else
      response = "#{parser.get_input.upcase} is not a known word."
    end
    response
  end

end
