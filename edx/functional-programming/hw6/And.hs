-- | alternative implementations of Prelude#any

module And where

any1, any2, any3, any4, any5 :: (a -> Bool) -> [a] -> Bool

any1 p = or . map p

any2 p xs = length (filter p xs) > 0

any3 p = not . null . dropWhile (not . p)

any4 p xs = not (all (\ x -> not (p x)) xs)

any5 p xs = foldr (\ x acc -> (p x) || acc) False xs
