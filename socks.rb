require 'socket'

server = UNIXServer.new '/tmp/test.sock'
sock = server.accept
puts "this cat is saying: \"#{sock.read}\""
puts "time to let them know what I think"
sock.write "good morning dave\n"

sock.close
FileUtils.rm "/tmp/test.sock"

