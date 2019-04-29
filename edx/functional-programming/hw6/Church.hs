-- | Church numerals encode/decode

module Church where

type Church a = (a -> a) -> a -> a

church :: Integer -> Church Integer
church 0 = \f -> \x -> x
church n = \f -> \x -> f (church (n - 1) f x)

unchurch :: Church Integer -> Integer
unchurch c = c (+1) 0
