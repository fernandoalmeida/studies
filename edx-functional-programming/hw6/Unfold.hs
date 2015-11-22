-- | encapsulates a simple pattern of recursion for producing a list

module Unfold where

unfold :: (b -> Bool) -> (b -> a) -> (b -> b) -> b -> [a]

unfold p h t x
  | p x = []
  | otherwise = h x : unfold p h t (t x)

-- Example
type Bit = Int

int2bin, int2binu :: Int -> [Bit]

-- without unfold
int2bin 0 = []
int2bin n = n `mod` 2 : int2bin (n `div` 2)

-- with unfold
int2binu = unfold (== 0) (`mod` 2) (`div` 2)

-- without unfold
chop8, chop8u :: [Bit] -> [[Bit]]
chop8 [] = []
chop8 bits = take 8 bits : chop8 (drop 8 bits)

-- with unfold
chop8u = unfold null (take 8) (drop 8)

-- without unfold
map1, map2 :: (a -> b) -> [a] -> [b]
map1 _ [] = []
map1 f (x:xs) = f x : map1 f xs

-- with unfold
map2 f = unfold null (f . head) tail

-- without unfold
iterate1, iterate2 :: (a -> a) -> a -> [a]
iterate1 f x = x : iterate1 f (f x)

-- with unfold
iterate2 f = unfold (const False) id f
