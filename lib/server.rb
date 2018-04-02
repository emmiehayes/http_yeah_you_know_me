require 'socket'

class Server
  attr_reader :tcp_server

  def initialize(port)
    @tcp_server = TCPServer.new(port)
  end

  def start_server
    p "Ready for message"
    client = @tcp_server.accept  #gateway

    loop do
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
    p request_lines
    end
  end
end

x = Server.new(9292)
x.start_server






#
#     puts "Got this request:"
#     puts request_lines.inspect
#   end
#
#
#
# puts "Sending response."
# response = "<pre>" + request_lines.join("\n") + "</pre>"
# output = "<html><head></head><body>#{response}</body></html>"
# headers = ["http/1.1 200 ok",
#           "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#           "server: ruby",
#           "content-type: text/html; charset=iso-8859-1",
#           "content-length: #{output.length}\r\n\r\n"].join("\r\n")
# client.puts headers
# client.puts output
#
# puts ["Wrote this response:", headers, output].join("\n")
# client.close
# # puts "\nResponse complete, exiting."