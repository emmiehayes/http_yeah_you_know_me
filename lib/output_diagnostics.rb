module OutputDiagnostics

  def verb_select(request_lines)
    request_lines[0].split[0]
  end

  def path_select(request_lines)
    request_lines[0].split[1]
  end

  def protocol_select(request_lines)
    request_lines[0].split[2]
  end

  def host_origin_select(request_lines)
    request_lines[1].split(" ")[1]
  end

  def port_select(request_lines)
    request_lines[1].split(" ")[1].split(":")[1]
  end

  def accept_select(request_lines)
    request_lines[6].split(" ")[1]
  end
end
