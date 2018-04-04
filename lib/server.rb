require 'socket'
require_relative 'response_generator'

class Server
  attr_reader :tcp_server

  def initialize(port)
    @tcp_server = TCPServer.new(port)
    start_server
  end

  def start_server
    response = ResponseGenerator.new                                              #initiate the Response Generator in Server class
    loop do
      p "Ready for message"
      client = @tcp_server.accept                                                 #server is accepting the connection from the client
      request_lines = []                                                          #request_lines to empty array, stores what comes in from the client
      while line = client.gets and !line.chomp.empty?                             #coming from the client, while loop waiting for space after string
        request_lines << line.chomp                                               #shoveling in the client data
      end
      p request_lines                                                             #print/inspect the array of requested_lines to terminal
      response.receive_request_lines(request_lines)                               #i sent requested_lines array to the response_generator for formatting
      x = response.reader(request_lines)                                         #setting a variable to pull requested_lines after formatted/header..etc
      client.puts x                                                             #putsing the output from line 23 back to client
    end
  end
end

x = Server.new(9292)
