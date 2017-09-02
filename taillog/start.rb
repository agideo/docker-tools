require 'socket'

server = TCPServer.new('0.0.0.0', 80)
line_count = ENV["LINE_COUNT"].to_i
line_count = [10, line_count].max

loop do
  socket = server.accept
  request = socket.gets

  STDERR.puts request
  response = ""
  response << `tail -n #{line_count} /opt/taillog.log`
  response << "\n"

  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"

  socket.print "\r\n"
  socket.print response
  socket.close
end
