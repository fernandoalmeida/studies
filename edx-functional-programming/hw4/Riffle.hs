module Riffle where

riffle :: [a] -> [a] -> [a]
riffle xs ys = concat [[x, y] | (x, y) <- zip xs ys]
