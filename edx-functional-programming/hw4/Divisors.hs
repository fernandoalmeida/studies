module Divisors where

divides :: Int -> Int -> Bool
divides x y = x `mod` y == 0

divisors :: Int -> [Int]
divisors x = [n | n <- [1..x], x `divides` n]
