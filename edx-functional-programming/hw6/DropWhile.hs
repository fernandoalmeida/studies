-- | alternative implementation of Prelude#dropwhile

module DropWhile where

import Prelude hiding (dropWhile)

dropWhile :: (a -> Bool) -> [a] -> [a]

dropWhile _ [] = []
dropWhile p (x : xs)
  | p x = dropWhile p xs
  | otherwise = x : xs
