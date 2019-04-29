-- | converts Integer (>= 0) into Nat

module IntegerToNat where

-- import Hugs.IOExts (unsafeCoerce)
import Prelude hiding (Maybe (..))


data Nat = Zero
         | Succ Nat
         deriving Show

----------------------------------

integerToNat :: Integer -> Nat
integerToNat 0 = Zero
integerToNat n = Succ (integerToNat (n - 1))

-- integerToNat1, integerToNat2, integerToNat3 :: Integer -> Nat

-- integerToNat1 0 = Zero
-- integerToNat1 (n + 1) = Succ (integerToNat1 n)

-- integerToNat2 (n + 1) = Succ (integerToNat2 n)
-- integerToNat2 0 = Zero

-- integerToNat3 (n + 1) = let m = integerToNat3 n in Succ m
-- integerToNat3 0 = Zero

----------------------------------

add1, add2, add3, add4 :: Nat -> Nat -> Nat

add1 Zero n = n
add1 (Succ m) n = Succ (add1 n m)

add2 (Succ m) n = Succ (add2 n m)
add2 Zero n = n

add3 n Zero = n
add3 n (Succ m) = Succ (add3 m n)

add4 n (Succ m) = Succ (add4 m n)
add4 n Zero = n

----------------------------------

mult :: Nat -> Nat -> Nat
mult m Zero = Zero
mult m (Succ n) = add1 m (mult m n)

-- test_mult f = [(f Zero two),
--                (f two Zero),
--                (f two three)] == [Zero, Zero, six]
--   where two   = integerToNat 2
--         three = integerToNat 3
--         six   = integerToNat 6

----------------------------------

data Tree = Leaf Integer
          | Node Tree Integer Tree


fake_tree :: Tree
fake_tree = (Node l 5 r) where l = (Node (Leaf 2) 3 (Leaf 4))
                               r = (Leaf 7)

test_occurs f = [f x fake_tree | x <- [1..9] ] == expected
  where expected = [False, True, True, True, True, False, True, False, False]

occurs1, occurs2 :: Integer -> Tree -> Bool

occurs1 m (Leaf n) = m == n
occurs1 m (Node l n r)
  = case compare m n of
         LT -> occurs1 m l
         EQ -> True
         GT -> occurs1 m r

occurs2 m (Leaf n) = m == n
occurs2 m (Node l n r)
  | m == n = True
  | m < n = occurs2 m l
  | otherwise = occurs2 m r

----------------------------------

data Tree2 = Leaf2 Integer
           | Node2 Tree2 Tree2

balanced :: Tree2 -> Bool
leaves (Leaf2 _) = 1
leaves (Node2 l r) = leaves l + leaves r
balanced (Leaf2 _) = True
balanced (Node2 l r) = abs (leaves l - leaves r) <= 1 && balanced l && balanced r

fake_balanced, fake_not_balanced :: Tree2
fake_balanced = (Node2 l r) where l = (Node2 (Leaf2 3) (Leaf2 4))
                                  r = (Node2 (Leaf2 5) (Leaf2 6))

fake_not_balanced = (Node2 l r) where l = (Node2 (Leaf2 3) (Leaf2 4))
                                      r = (Node2 rl rr)
                                      rl = (Node2 (Leaf2 5) (Leaf2 6))
                                      rr = (Node2 (Leaf2 5) (Leaf2 6))

test_balanced = balanced fake_balanced == True &&
                balanced fake_not_balanced == False

----------------------------------

data Maybe a = Nothing
             | Just a
             deriving Show
instance Monad Maybe where
  return x = Just x
  Nothing >>= _ = Nothing
  (Just x) >>= f = f x

----------------------------------

class Monoid m where
    mempty  :: m
    (<>) :: m -> m -> m

instance Monoid [a] where
  mempty = []
  (<>) = (++)

----------------------------------
