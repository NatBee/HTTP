gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/word_search'


class WordSearchTest < Minitest::Test

  def test_it_gets_checks_words
    outputting_diagnostics = ["GET /word_search?=pet HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    word_search = WordSearch.new(outputting_diagnostics)
    assert_equal "PET is a known word.", word_search.word_search
  end

  def test_it_gets_checks_non_words
    outputting_diagnostics = ["GET /word_search?=ohh HTTP/1.1",
  "Host: 127.0.0.1:9292",
  "Connection: keep-alive",
  "Cache-Control: no-cache",
  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
  "Postman-Token: ee734471-eabf-1a5b-6b62-70d917fff4a5",
  "Accept: */*",
  "Accept-Encoding: gzip, deflate, sdch, br",
  "Accept-Language: en-US,en;q=0.8"]
    word_search = WordSearch.new(outputting_diagnostics)
    assert_equal "OHH is not a known word.", word_search.word_search
  end
end
