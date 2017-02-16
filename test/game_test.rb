gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_outputs_start_game_response
    outputting_diagnostics = ["POST /start_game HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    response = Game.new(outputting_diagnostics)
    assert_equal "Good luck!", response.start_game
  end
end
