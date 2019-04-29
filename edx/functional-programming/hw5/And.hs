module And where

and1 [] = True
and1 (b:bs) = b && and bs

and2 [] = True
and2 (b:bs)
  | b = and2 bs
  | otherwise = False


and3 [] = True
and3 (b:bs)
  | b == False = False
  | otherwise = and3 bs

and4 [] = True
and4 (b:bs) = and bs && b
