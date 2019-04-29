module Msort where

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y : ys)
  | otherwise = y : merge (x : xs) ys

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort ys) (msort zs)
  where (ys, zs) = splitAt (length xs `div` 2) xs
