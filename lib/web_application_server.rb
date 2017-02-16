require 'socket'
require './lib/parser'
require 'pry'

class HTTP
attr_reader :tcp_server, :counter, :request_lines, :aggregate_requests, :server_exit

  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
    @request_lines = []
    @aggregate_requests = 0
    @server_exit = false
    @guess_count = 0
  end

  def default_path
    parser = Parser.new(request_lines)
    response = "<pre>\n" + "Verb: #{parser.get_verb}\n" +
      "Path: #{parser.get_path}\n" +
      "Protocol: #{parser.get_protocol}\n" +
      "Host: #{parser.get_host}\n" +
      "Port: #{parser.get_port}\n" +
      "Origin: #{parser.get_host}\n" +
      "Accept: #{parser.get_accept}\n" + "</pre>"
      @aggregate_requests += 1
      response
  end

  def hello_path
    response = "<pre>" + "Hello, World! (#{@counter})" + "</pre>"
    @counter += 1
    @aggregate_requests += 1
    response
  end

  def datetime_path
    response = Time.now.strftime("%H:%M%p on %A, %B %d, %Y." )
    @aggregate_requests += 1
    response
  end

  def shutdown_path
    response = "Total Requests: #{@aggregate_requests}"
    @aggregate_requests += 1
    @server_exit = true
    response
  end

  def word_search(get_input)
    parser = Parser.new(request_lines)
    dictionary = File.read("/usr/share/dict/words").split("\n")
    if dictionary.include?(parser.get_input)
      response = "#{parser.get_input.upcase} is a known word"
    else
      response = "#{parser.get_input.upcase} is not a known word"
    end
    @aggregate_requests += 1
    response
  end

  def start_game
    server_random_number = Random.new
    @random_num = server_random_number.rand(100)
    @aggregate_requests += 1
    response = "Good luck!"
  end

  # def game(get_input)
  #
  # end

  def game_response(get_input)
    @guess_count += 1
    @aggregate_requests += 1

    if get_input.to_i < @random_num
      guess_status = "too low"
    elsif get_input.to_i > @random_num
      guess_status = "too high"
    else
      guess_status = "correct"
    end

    response = "#{@guess_count} guesses have been taken. " + "Your guess #{get_input} is #{guess_status}."
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


      puts "Sending response."
      if parser.get_path == "/"
        response = default_path
      elsif parser.get_path == "/hello"
        response = hello_path
      elsif parser.get_path == "/datetime"
        response = datetime_path
        # response = Response.new.datetime_response
      elsif parser.get_path.include?("/word_search")
        response = word_search(parser.get_input)
        # response = Response.new.word_search_response(parser.get_input)
      elsif parser.get_path == "/shutdown"
        response = shutdown_path
      elsif parser.get_path == "/start_game" && parser.get_verb == "POST"
        response = start_game
      # elsif get_path(request_lines).include?("/game")
      #   response = game(get_input(request_lines))
    elsif parser.get_path.include?("/game") && parser.get_verb == "POST"
        response = game_response(get_input(request_lines))

      end

      output = "#{response}"
      headers = ["http/1.1 200 ok",
                  "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                  "server: ruby",
                  "content-type: text/html; charset=iso-8859-1",
                  "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output
    end

      client.close

      puts ["Wrote this response:", headers, output].join("\n")
      puts "\nResponse complete, exiting."
  end
end
