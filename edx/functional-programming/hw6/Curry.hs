-- | alternative implamentation of Prelude curry

module Curry where

import Prelude hiding (curry)

curry :: ((a, b) -> c) -> a -> b -> c

curry f = \ x y -> f (x, y)
