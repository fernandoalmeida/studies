module Fetch where

import Prelude hiding ((!!))

(x:_) !! 0 = x
(_:xs) !! n = xs !! (n - 1)
