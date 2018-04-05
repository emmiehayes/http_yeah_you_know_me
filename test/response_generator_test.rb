require 'minitest/autorun'
require 'minitest/test'
require 'pry'
require_relative '../lib/response_generator'

class ResponseGeneratorTest <Minitest::Test

  def test_it_exists
    response = ResponseGenerator.new
    assert_instance_of ResponseGenerator, response
  end

  def test_path_can_be_accessed
    response = ResponseGenerator.new
    assert_equal "/hello", response.find_path(["GET /hello HTTP/1.1", "Host: localhost:9292", "Connection: keep-alive", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8", "Accept-Encoding: gzip, deflate, br", "Accept-Language: en-US,en;q=0.9"])
  end

  def 
  end


end
