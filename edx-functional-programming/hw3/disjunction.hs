module Disjunction where

import Prelude hiding ((||))

-- False || False = False
-- _ || _ = True

-- False || b = b
-- True || _ = True

-- b || c
--     | b == c = b
--     | otherwise = True

-- b || False = b
-- _ || True = True

False || False = False
False || True = True
True || False = True
True || True = True
