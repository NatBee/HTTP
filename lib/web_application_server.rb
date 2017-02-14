require 'socket'

class HTTP
attr_reader :tcp_server, :counter

  def initialize
    @tcp_server = TCPServer.new(9292)
    @counter = 0
  end

  def response
    while client = tcp_server.accept

      puts "Ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      puts "Got this request:"
      puts request_lines.inspect
      puts "Sending response."
        if request_lines[0] == "GET /favicon.ico HTTP/1.1"
          client.puts["http/1.1 404 not-found"]
        next
        end
      response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output
      @counter += 1
    end

      client.close

      puts ["Wrote this response:", headers, output].join("\n")
      puts "\nResponse complete, exiting."
  end
end

http = HTTP.new
http.response
