-- | alternative implementation of Prelude#takeWhile

module TakeWhile where

import Prelude hiding (takeWhile)

takeWhile :: (a -> Bool) -> [a] -> [a]

takeWhile _ [] = []
takeWhile p (x : xs)
  | p x = x : takeWhile p xs
  | otherwise = []
