require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test
  #removed this instance of test because it kept me from accessing the test below it- it would open up the server
  # def test_server_responds_to_ping
  #   @server = Server.new(9292)
  #   assert_instance_of Server, @server
  # end

  def test_it_displays_hello_world_in_body
    response = Faraday.get 'http://localhost:9292/hello'
    actual= response.body
    assert actual.include?("Hello World!")
  end

  #test are sensitive to counters, date/time changing..etc

  def test_it_displays_date_time_in_body
    response = Faraday.get 'http://localhost:9292/datetime'
    actual= response.body
    assert actual.include?("April")
  end

#not going to make a shut down test because if it happens to be the first test that is run it will shut down my server and they remaining test will fail.






end
