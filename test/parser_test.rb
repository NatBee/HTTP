gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/parser'

class ParserTest < Minitest::Test

  def test_it_gets_a_verb
    outputting_diagnostics = ["GET / HTTP/1.1",
 "Host: 127.0.0.1:9292",
 "Connection: keep-alive",
 "Cache-Control: no-cache",
 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
 "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
 "Accept: */*",
 "Accept-Encoding: gzip, deflate, sdch, br",
 "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "GET", parser.get_verb
  end

  def test_it_gets_a_path
    outputting_diagnostics = ["GET / HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "/", parser.get_path
  end

  def test_it_gets_a_protocol
    outputting_diagnostics = ["GET / HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "HTTP/1.1", parser.get_protocol
  end

  def test_it_gets_a_host
    outputting_diagnostics = ["GET / HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "127.0.0.1", parser.get_host
  end

  def test_it_gets_a_port
    outputting_diagnostics = ["GET / HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "9292", parser.get_port
  end

  def test_it_gets_accept
    outputting_diagnostics = ["GET / HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "*/*", parser.get_accept
  end

  def test_it_gets_an_input
    outputting_diagnostics = ["GET /word?=dog HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    parser = Parser.new(outputting_diagnostics)

    assert_equal "dog", parser.get_input
  end

end
