require 'socket'
require 'fileutils'

# FIXME Deal with the fact that `Socket#read` is blocking until either
# a certain number of bytes or EOF (in this case, until EOF, which makes reuse
# kinda hard)
begin
  server = UNIXServer.new '/tmp/test.sock'
  sock = server.accept
  puts "this cat is saying: \"#{sock.read_nonblock 1024}\""
  puts "time to let them know what I think"
  sock.write "good morning dave\n"
  
  sock.close
ensure
  FileUtils.rm "/tmp/test.sock"
end

