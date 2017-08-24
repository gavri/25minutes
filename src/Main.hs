module Main where

import Control.Concurrent
import Control.Monad
import Data.Time.Units
import DBus.Notify

message content = do
  client <- connectSession
  let fullMessage = blankNote { summary = content, body = Just $ Text content}
  notification <- notify client fullMessage
  return ()

work = (threadDelay $ fromIntegral (toMicroseconds (25 :: Minute))) >> message "work done"
play = (threadDelay $ fromIntegral (toMicroseconds (5 :: Minute))) >> message "play done"

session = work >> play

main :: IO ()
main = do
  replicateM 4 session >> return ()
