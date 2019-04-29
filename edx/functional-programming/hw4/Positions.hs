module Positions where

find :: Eq a => a -> [(a, b)] -> [b]
find x xs = [n | (x', n) <- xs, x == x']

positions :: (Eq a) => a -> [a] -> [Int]
positions x xs = find x (zip xs [0..n])
  where n = length xs - 1
