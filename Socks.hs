module Main where

import Network.Socket hiding (send)
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as B

main :: IO ()
main = do
  sock <- socket AF_UNIX Stream 0
  connect sock $ SockAddrUnix "/tmp/test.sock"
  sendAll sock $ B.pack "hello world"
  text <- recv sock 4
  B.putStrLn . B.pack $ "did they really just say: \"" ++ (B.unpack text) ++ "\"?"
  close sock

