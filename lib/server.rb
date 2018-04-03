require 'socket'
require_relative 'response_generator'

class Server
  attr_reader :tcp_server

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    start_server
  end

  def start_server
    response = ResponseGenerator.new
    loop do
      p "Ready for message"
      client = @tcp_server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      p request_lines
      response.receive_request_lines(request_lines)
      output = response.reader(request_lines)
      client.puts output
    end
  end
end

x = Server.new(9292)
