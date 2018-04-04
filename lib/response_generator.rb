require_relative 'output_diagnostics'

class ResponseGenerator
  include OutputDiagnostics

  attr_reader :request_lines,
              :counter,
              :total_count

  def initialize
    @request_lines = []
    @counter = 0
    @total_count = 0
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
    ["http/1.1 200 ok",
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

  def request_parser(request_lines)
    path = find_path(request_lines)
    @total_count += 1
    case
    when path == "/hello"         then hello_world_response
    when path == "/"              then debug_response(request_lines)
    when path == "/datetime"      then time_response
    when path == "/shutdown"      then shutdown_response
    when path == "/wordsearch"    then word_search_response
    else
        text = request_lines.join("\n")
        assemble_foh(text)
    end
  end

  def debug_response(request_lines)
    text = "Verb: #{verb_select(request_lines)}\n" +
           "Path: #{path_select(request_lines)}\n" +
           "Protocol: #{protocol_select(request_lines)}\n" +
           "Host: #{host_origin_select(request_lines)}\n" +
           "Port: #{port_select(request_lines)}\n" +
           "Origin: #{host_origin_select(request_lines)}\n" +
           "Accept: #{accept_select(request_lines)}\n"
    assemble_foh(text)
  end

  def hello_world_response
    @counter += 1
    text = "Hello World! (#{@counter})"
    assemble_foh(text)
  end

  def time_response
    time = Time.now.strftime('%l:%M%p on %A, %B%e, %Y')
    assemble_foh(time)
  end

  def shutdown_response
    assemble_foh("Server shut down, total request = #{@total_count}")
  end
end
