-- | Convert Nat to Integer

module Nat2int where

import Data.List
import Data.Char
-- import Hugs.IOExts (unsafeCoerce)

data Nat = Zero
         | Succ Nat
         deriving Show

natToInteger1, natToInteger2, natToInteger3, natToInteger4, natToInteger5 :: Nat -> Integer

natToInteger1 Zero = 0
natToInteger1 (Succ n) = natToInteger1 n + 1

natToInteger2 (Succ n) = natToInteger2 n + 1
natToInteger2 Zero = 0

natToInteger3 (Succ n) = 1 + natToInteger3 n
natToInteger3 Zero = 0

natToInteger4 = head . m where m Zero = [0]
                               m (Succ n) = [sum [x | x <- (1 : m n)]]

natToInteger5 = \n -> genericLength [c | c <- show n, c == 'S']
