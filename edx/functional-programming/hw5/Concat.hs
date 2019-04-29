module Concat where

import Prelude hiding (concat)

concat [] = []
concat (xs:xss) = xs ++ concat xss
