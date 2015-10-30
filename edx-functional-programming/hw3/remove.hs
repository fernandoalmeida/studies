module Remove where
    remove n xs = take n xs ++ drop (n + 1) xs
