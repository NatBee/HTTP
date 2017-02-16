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

  i_suck_and_my_tests_are_order_dependant!
    def test_a_path_is_outputing_correct_response_path_root
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

    def test_b_path_is_outputing_correct_response_path_root_hello
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal "<html><head></head><body><pre>Hello, World! (0)</pre></body></html>", response.body
    end

    def test_c_root_hello_is_incrementing_only_with_root_hello_request
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal "<html><head></head><body><pre>Hello, World! (0)</pre></body></html>", response.body

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

      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal "<html><head></head><body><pre>Hello, World! (1)</pre></body></html>", response.body
    end

    def test_d_path_is_outputing_correct_response_path_root_datetime
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal "11:07AM on Tuesday, February 14, 2017", response.body
    end

    def test_e_path_is_outputing_correct_response_path_root_shutdown
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal “Total Requests: 12”, response.body
    end

    def test_f_it_counts_all_requests
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal “Total Requests: 12”, response.body
    end

    def test_g_word_search_is_outputing_correct_response_for_DOG
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal “DOG is a known word”, response.body
    end

    def test_h_word_search_is_outputing_correct_response_for_OOH
      response = Faraday.get 'http://127.0.0.1:9292'
      assert_equal “OOH is not a known word”, response.body
    end



end
