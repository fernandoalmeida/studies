-- | String functions

module Str where

-- takes a String and writes it to the standard output
putStr' :: String -> IO ()
putStr' [] = return ()
putStr' (x:xs) = putChar x >> putStr' xs

-- takes a String and writes it to the standard output, followed by a newline
putStrLn1, putStrLn2, putStrLn3, putStrLn4 :: String -> IO ()

putStrLn1 [] = putChar '\n'
putStrLn1 xs = putStr' xs >> putStrLn1 ""

putStrLn2 [] = putChar '\n'
putStrLn2 xs = putStr' xs >> putChar '\n'

putStrLn3 [] = putChar '\n'
putStrLn3 xs = putStr' xs >>= \_ -> putChar '\n'

putStrLn4 [] = putChar '\n'
putStrLn4 xs = putStr' xs >> putStr' "\n"

-- reads a line, up to the first \n character, from the standard input
getLine' :: IO String
getLine' = get []

get :: String -> IO String
get xs = do x <- getChar
            case x of
                 '\n' -> return xs
                 _ -> get (xs ++ [x])

-- takes a function, reads a line from the STDIN, and passes it to this
-- function, and prints the output followed by a newline on the STDOUT
iteract' :: (String -> String) -> IO ()
iteract' f = do input <- getLine'
                putStrLn1 (f input)

-- takes a list of monadic values, and evaluates them from left to right
-- ignoring all intermediate results
sequence_1, sequence_2, sequence_3, sequence_4 :: Monad m => [m a] -> m ()

sequence_1 [] = return ()
sequence_1 (m : ms) = (foldl (>>) m ms) >> return ()

sequence_2 [] = return ()
sequence_2 (m : ms) = m >> sequence_2 ms

sequence_3 [] = return ()
sequence_3 (m : ms) = m >>= \_ -> sequence_3 ms

sequence_4 ms = foldr (>>) (return ()) ms

-- takes a list of monadic values, and evaluates them from left to right
-- collecting all intermediate results

sequence_5, sequence_6 :: Monad m => [m a] -> m [a]

sequence_5 [] = return []
sequence_5 (m : ms) = m >>= \a -> do as <- sequence_5 ms
                                     return (a : as)

sequence_6 [] = return []
sequence_6 (m : ms) = do a <- m
                         as <- sequence_6 ms
                         return (a : as)

-- sequence_7 ms = foldr func (return []) ms where
--   func :: (Monad a) => m a -> m [a] -> m [a]
--   func m acc = do x <- m
--                   xs <- acc
--                   return (x : xs)

-- takes a function and a list
-- applies the function to every element of the list
-- returns a list wrapped inside a monadic action
mapM1, mapM2, mapM3, mapM4 :: (Monad m) => (a -> m b) -> [a] -> m [b]

mapM1 f as = sequence_5 (map f as)

mapM2 _ [] = return []
mapM2 f (a : as) = f a >>= (\b -> mapM2 f as >>= \bs -> return (b : bs))

mapM3 _ [] = return []
mapM3 f (a : as) = do b <- f a
                      bs <- mapM3 f as
                      return (b : bs)

mapM4 _ [] = return []
mapM4 f (a : as) = f a >>= \b -> do bs <- mapM4 f as
                                    return (b : bs)

-- takes a "predicate" and uses to filter a list preserving the order
filterM' :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM' _ [] = return []
filterM' p (a : as) = do success <- p a
                         as' <- filterM' p as
                         if success then return (a : as') else return as'

foldLeftM :: Monad m => (a -> b -> m a) -> a -> [b] -> m a
foldLeftM _ a [] = return a
foldLeftM f a (x : xs) = do a' <- f a x
                            foldLeftM f a' xs

foldRightM :: Monad m => (a -> b -> m b) -> b -> [a] -> m b
foldRightM _ a [] = return a
foldRightM f a (x : xs) = do a' <- foldRightM f a xs
                             f x a'

liftM1, liftM2, liftM3, liftM4 :: Monad m => (a -> b) -> m a -> m b

liftM1 f m = do x <- m
                return (f x)

liftM2 f m = m >>= \a -> return (f a)

liftM3 f m = m >>= \a -> m >>= \_ -> return (f a)

liftM4 f m = m >>= \_ -> m >>= \b -> return (f b)
