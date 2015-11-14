module Elem where

import Prelude hiding (elem)

elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem e (x:xs)
  | e == x = True
  | otherwise = elem e xs
