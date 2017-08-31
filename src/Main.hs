module Main where

import Control.Concurrent
import Control.Monad
import Data.Time.Units
import DBus.Notify

message handle content = do
  client <- connectSession
  let fullMessage = blankNote { summary = content, body = Just $ Text content}
  notification <- replace client handle fullMessage
  return notification

start = do
  client <- connectSession
  let fullMessage = blankNote { summary = "Start", body = Just $ Text "Start"}
  handle <- notify client fullMessage
  return handle

work handle = (threadDelay $ fromIntegral (toMicroseconds (25 :: Minute))) >> message handle "work done"
play handle = (threadDelay $ fromIntegral (toMicroseconds (5 :: Minute))) >> message handle "play done"

session handle = work(handle) >>= play

main :: IO ()
main = start >>= session >>= session >>= session >>= session >> return ()
