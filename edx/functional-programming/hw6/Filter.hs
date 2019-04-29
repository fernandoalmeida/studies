-- | alternative implementation of Prelude#filter

module Filter where

filterl, filterr :: (a -> Bool) -> [a] -> [a]

-- foldl version
filterl p = foldl (\ xs x -> if p x then xs ++ [x] else xs) []

-- foldr version
filterr p = foldr (\ x xs -> if p x then [x] ++ xs else xs) []
