class ResponseGenerator
  attr_reader :request_lines,
              :counter,
              :client

  def initialize
    @request_lines = []
    @counter = 0
  end

  def receive_request_lines(request_lines)
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
    if path == "/hello"
      hello_world_response
    else
      text = request_lines.join("\n")
      assemble_foh(text)
    end
  end

  def hello_world_response
    @counter += 1
    text = "Hello World! (#{@counter})"
    assemble_foh(text)
  end

end
