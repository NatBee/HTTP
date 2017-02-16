require './lib/web_application_server'

class Parser
  attr_reader :lines

  def initialize(lines)
    @lines = lines
  end

  def get_verb
    lines[0].split(" ")[0]
  end

  def get_path
    lines[0].split(" ")[1]
  end

  def get_protocol
    lines[0].split(" ")[2]
  end

  def get_host
    lines[1].split(" ")[1].split(":")[0]
  end

  def get_port
    lines[1].split(" ")[1].split(":")[1]
  end

  def get_accept
    lines[6].split(" ")[1]
  end

  def get_input
    lines[0].split("=")[1].split(" ")[0]
  end

end
