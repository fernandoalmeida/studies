-- |

module Fibonacci where

fibs :: [Integer]
fibs = 0 : 1 : [x + y | (x, y) <- zip fibs (tail fibs)]

fib :: Int -> Integer
fib n = fibs !! n

largeFib :: Integer
largeFib = head (dropWhile (<= 1000) fibs)
