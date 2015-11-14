module ParallelComprehensions where

serial = [(x, y) | x <- [1..3], y <- [4..6]]

parallel = concat [[(x, y) | y <- [4..6]] | x <- [1..3]]

-- λ> serial == parallel
-- True
