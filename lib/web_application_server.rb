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

      if request_lines[0] == "GET /favicon.ico HTTP/1.1"
        client.puts["http/1.1 404 not-found"]
        next
      end

      puts "Got this request:"
      puts request_lines.inspect

      verb = request_lines[0].split(" ")[0]
      path = request_lines[0].split(" ")[1]
      protocol = request_lines[0].split(" ")[2]
      host = request_lines[1].split(" ")[1].split(":")[0]
      port = request_lines[1].split(" ")[1].split(":")[1]
      accept = request_lines[6].split(" ")[1]

      puts "Sending response."
      response = "<pre>" + "Hello, World! (#{counter})" + "</pre>"
      output_response = "<pre>\n" + "Verb: #{verb}\n" +
        "Path: #{path}\n" +
        "Protocol: #{protocol}\n" +
        "Host: #{host}\n" +
        "Port: #{port}\n" +
        "Origin: #{host}\n" +
        "Accept: #{accept}" + "<pre>"
      output = "<html><head></head><body>#{response}</body></html>" + "\n" + "#{output_response}"
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
