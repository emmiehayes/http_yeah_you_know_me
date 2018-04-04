require 'socket'
require 'pry'
require_relative 'response_generator'

class Server
  attr_reader :tcp_server,
              :client

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @client = nil
    start_server
  end

  def start_server
    response = ResponseGenerator.new
    loop do
      p "Ready for message"
      @client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      p request_lines
      response.receive_request_lines(request_lines)
      x = response.request_parser(request_lines)
      @client.puts x
      end_server if x.include?("shut")
    end
  end

  def end_server
    @tcp_server.close
  end
end

x = Server.new(9292)
