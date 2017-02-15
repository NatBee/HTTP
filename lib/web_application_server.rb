require 'socket'
require './lib/path'
require 'pry'

class HTTP
attr_reader :tcp_server, :counter, :request_lines, :aggregate_requests, :server_exit

  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
    @request_lines = []
    @aggregate_requests = 0
    @server_exit = false
  end

  def get_verb(request_lines)
    request_lines[0].split(" ")[0]
  end

  def get_path(request_lines)
    request_lines[0].split(" ")[1]
  end

  def get_protocol(request_lines)
    request_lines[0].split(" ")[2]
  end

  def get_host(request_lines)
    request_lines[1].split(" ")[1].split(":")[0]
  end

  def get_port(request_lines)
    request_lines[1].split(" ")[1].split(":")[1]
  end

  def get_accept(request_lines)
    request_lines[6].split(" ")[1]
  end

  def get_word(request_lines)
    request_lines[0].split("=")[1].split(" ")[0]
  end

  def default_path
    response = "<pre>\n" + "Verb: #{get_verb(request_lines)}\n" +
      "Path: #{get_path(request_lines)}\n" +
      "Protocol: #{get_protocol(request_lines)}\n" +
      "Host: #{get_host(request_lines)}\n" +
      "Port: #{get_port(request_lines)}\n" +
      "Origin: #{get_host(request_lines)}\n" +
      "Accept: #{get_accept(request_lines)}\n" + "</pre>"
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

  def word_search(get_word)
    dictionary = File.read("/usr/share/dict/words").split("\n")
    if dictionary.include?(get_word)
      response = "#{get_word.upcase} is a known word"
    else
      response = "#{get_word.upcase} is not a known word"
    end
    @aggregate_requests += 1
    response
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


      puts "Sending response."
      if get_path(request_lines) == "/"
        response = default_path
      elsif get_path(request_lines) == "/hello"
        response = hello_path
      elsif get_path(request_lines) == "/datetime"
        response = datetime_path
      elsif get_path(request_lines).include?("/word_search")
        response = word_search(get_word(request_lines))
      elsif get_path(request_lines) == "/shutdown"
        response = shutdown_path
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
      binding.pry
  end
end
