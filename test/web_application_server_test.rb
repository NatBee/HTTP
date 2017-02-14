gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'faraday'
require 'pry'


class HTTPTest < Minitest::Test

  def test_counter_is_incrementing
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (0)</pre></body></html>", response.body

    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (1)</pre></body></html>", response.body
  end

  def test_it_handles_favicon_request_path
    response = Faraday.get 'http://127.0.0.1:9292/favicon.ico'
    assert_equal "http/1.1 404 not-found", response.body
  end

  def test_it_outputting_diagnostics
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<pre>
    Verb: GET
    Path: /
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: */*
    </pre>", response.body
  end

end
