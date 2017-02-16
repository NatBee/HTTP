require 'socket'
require './lib/parser'
require './lib/response'
require './lib/word_search'
require './lib/game'

class HTTP
attr_reader :tcp_server, :counter, :request_lines, :aggregate_requests, :server_exit

  def initialize
    @tcp_server = TCPServer.new(9292)
    @request_lines = []
    @counter = 0
    @aggregate_requests = 0
    @server_exit = false
  end

  def response
    until @server_exit == true
      client = tcp_server.accept

      puts "Ready for a request"
      @request_lines = []
      while line = client.gets and !line.chomp.empty?
        @request_lines << line.chomp
      end

      if request_lines[0] == "GET /favicon.ico HTTP/1.1"
        client.puts["http/1.1 404 not-found"]
        next
      end

      puts "Got this request:"
      puts request_lines.inspect

      parser = Parser.new(request_lines)
      response = Response.new(request_lines)
      word_search = WordSearch.new(request_lines)
      game = Game.new(request_lines)

      puts "Sending response."
      if parser.get_path == "/"
        response = response.default_path
      elsif parser.get_path == "/hello"
        @counter += 1
        response = "<pre>" + "Hello, World! (#{@counter})" + "</pre>" + response.default_path
      elsif parser.get_path == "/datetime"
        response = response.datetime_path
      elsif parser.get_path == "/shutdown"
        response = "Total Requests: #{@aggregate_requests}" + response.default_path
        @server_exit = true
      elsif parser.get_path.include?("/word_search")
        response = word_search.word_search + response.default_path
      elsif parser.get_path == "/start_game" && parser.get_verb == "POST"
        response = game.start_game + response.default_path
      elsif parser.get_path.include?("/game") && parser.get_verb == "POST"
        response = game.game_response + response.default_path

      end

      output = "#{response}"
      headers = ["http/1.1 200 ok",
                  "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                  "server: ruby",
                  "content-type: text/html; charset=iso-8859-1",
                  "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      @aggregate_requests += 1
      require 'pry'; binding.pry
    end

      client.close

      puts ["Wrote this response:", headers, output].join("\n")
      puts "\nResponse complete, exiting."
  end
end
