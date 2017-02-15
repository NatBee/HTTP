gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'faraday'
require 'pry'


class PathTest < Minitest::Test

  def test_path_is_outputing_correct_response_path_root
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal assert_equal "<pre>
    Verb: GET
    Path: /
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: */*
    </pre>", response.body
  end

  def test_path_is_outputing_correct_response_path_root_hello
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (0)</pre></body></html>", response.body
  end

  def test_root_hello_is_incrementing_only_with_root_hello_request
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (0)</pre></body></html>", response.body

    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal assert_equal "<pre>
    Verb: GET
    Path: /
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: */*
    </pre>", response.body

    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "<html><head></head><body><pre>Hello, World! (1)</pre></body></html>", response.body
  end

  def test_path_is_outputing_correct_response_path_root_datetime
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal "11:07AM on Sunday, November 1, 2015", response.body
  end

  def test_path_is_outputing_correct_response_path_root_shutdown
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal “Total Requests: 12”, response.body
  end

  def test_it_counts_all_requests
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal “Total Requests: 12”, response.body
  end

end
