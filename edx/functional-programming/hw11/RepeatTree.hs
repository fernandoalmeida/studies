-- |

module RepeatTree where

data Tree a = Leaf
            | Node (Tree a) a (Tree a)

repeatTree :: a -> Tree a
repeatTree x = Node t x t
  where t = repeatTree x
