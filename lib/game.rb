require './lib/web_application_server'
require './lib/parser'

class Game
  attr_reader :lines

  def initialize(lines)
    @lines = lines
    @guess_count = 0
  end

  def random_number
    server_random_number = Random.new
    @random_num = server_random_number.rand(100)

  end

  def start_game
    random_number
    response = "Good luck!"
  end

  def game_response
    random_number
    parser = Parser.new(lines)
    @guess_count += 1

    if parser.get_input.to_i < @random_num
      guess_status = "too low"
    elsif parser.get_input.to_i > @random_num
      guess_status = "too high"
    else
      guess_status = "correct"
    end

    response = "#{@guess_count} guesses have been taken. " + "Your guess #{parser.get_input} is #{guess_status}."
  end
end
