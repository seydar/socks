require 'socket'
require 'fileutils'

# `Socket#read` is blocking until either
# a certain number of bytes or EOF (in this case, until EOF, which makes reuse
# kinda hard)
#
# So now we have to read nonblocking of whatever's available, but we need to
# know when the client is done writing. Newline? EOF? \0?
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

