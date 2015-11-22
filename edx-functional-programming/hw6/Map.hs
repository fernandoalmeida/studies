-- | alternative implementation of Prelude#map

module Map where

mapl, mapr :: (a -> b) -> [a] -> [b]

-- foldl version
mapl f = foldl (\ xs x -> xs ++ [f x]) []

-- foldr version
mapr f = foldr (\ x xs -> [f x] ++ xs) []
