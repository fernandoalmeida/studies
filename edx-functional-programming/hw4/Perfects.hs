module Perfects where

factors :: Int -> [Int]
factors x = [n | n <- [1..x], x `mod` n == 0]

perfects :: Int -> [Int]
perfects x = [n | n <- [1..x], sum(init (factors n)) == n]
