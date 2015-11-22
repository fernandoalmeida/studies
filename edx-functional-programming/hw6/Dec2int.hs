-- | Convert a list of integers to integer

module Dec2int where

import Data.List

dec2intlc, dec2intr, dec2intfl :: [Integer] -> Integer

-- list comprehension version
dec2intlc xs = sum [x * 10^i | (x,i) <- zip xs (reverse [0..(length xs - 1)])]

-- recursive version
dec2intr [] = 0
dec2intr (x:xs) = x * 10^(length xs) + dec2intr xs

-- foldl version
dec2intfl = foldl (\ a e -> 10 * a + e) 0
