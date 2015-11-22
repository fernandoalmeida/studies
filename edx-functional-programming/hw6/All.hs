-- | alternative implementations of Prelude#all

module All where

all1, all2, all3, all4, all5 :: (a -> Bool) -> [a] -> Bool

all1 p xs = and (map p xs)

all2 p = and . map p

all3 p = not . any (not . p)

all4 p xs = foldl (&&) True (map p xs)

all5 p = foldr (&&) True . map p
