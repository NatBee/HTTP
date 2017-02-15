gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'faraday'
require 'pry'


class HTTPTest < Minitest::Test
i_suck_and_my_tests_are_order_dependant!
  def test_a_counter_is_incrementing
    skip
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (0)</pre></body></html>", response.body

    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (1)</pre></body></html>", response.body
  end

  def test_b_it_handles_favicon_request_path
    response = Faraday.get 'http://127.0.0.1:9292/favicon.ico'
    assert_equal "http/1.1 404 not-found", response.body
  end

  def test_c_it_outputting_diagnostics
skip
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
