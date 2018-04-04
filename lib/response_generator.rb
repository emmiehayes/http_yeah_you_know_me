class ResponseGenerator
  attr_reader :request_lines,
              :counter

  def initialize
    @request_lines = []                                                           #RG has to HAVE the request from the client so i set as attribute
    @counter = 0
    @total_count = 0                                                                 #RG- i put the counter here so that anytime it sends response it counts
  end

  def receive_request_lines(request_lines)                                        #method for RRL allows me to
    @request_lines = request_lines
  end

  def formatted_response(response)
    "<pre>" + response + "</pre>"
  end

  def output(response)
    "<html><head></head><body>#{response}</body></html>"
  end

  def headers(output)
    [
    "http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"
    ].join("\r\n")
  end

  def assemble_foh(text)
    formatted_text = formatted_response(text)
    output = output(formatted_text)
    headers = headers(output)
    headers + output
  end

  def find_path(request_lines)
    path = request_lines[0].split[1]
  end

  def reader(request_lines)
    path = find_path(request_lines)
    #replace if statement with case statement
    if path == "/hello"
      hello_world_response
    else
      text = request_lines.join("\n")
      assemble_foh(text)
    end
  end

  case
  when /hello         then hello_world_response
  when /              then debug_response
  when /datetime      then time_response
  when /shutdown      then shutdown_response

  def debug_response
    @total_count += 1
    #total_count needs to be included but not outputted to screen
    #code goes here (ITERATION 1)
  end

  def hello_world_response
    @total_count += 1
    @counter += 1
    text = "Hello World! (#{@counter})"
    assemble_foh(text)
  end

  def time_response
    @total_count += 1
    time = Time.now.strftime('%H:%M%p on %A,%B%d,%Y')
    assemble_foh(time)
  end

  def shutdown_response
      #cant mentipn client in response_generator- needs to move back through server
      puts ["Wrote this response:", headers, output].join("\n")

      client.close
      puts "\nResponse complete, exiting.\nTotal Requests: #{total_count}"
  end
end
