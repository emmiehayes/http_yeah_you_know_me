require 'socket'
require_relative 'response_generator'
require 'pry'

class Server
  attr_reader :tcp_server,
              :client

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @client = nil
    start_server          #runner file to handle
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
      client.puts x
      end_server if x.include?("shut")
    end
  end

  def end_server
    @client.close
    tcp_server.close
    exit
  end
end

x = Server.new(9292)
