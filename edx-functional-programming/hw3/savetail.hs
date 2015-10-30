module Safetail where
    safetail1 [] = []
    safetail1 (_ : xs) = xs

    safetail2 xs = if null xs then [] else tail xs

    safetail3 xs
        | null xs = []
        | otherwise = tail xs

    safetail4 [] = []
    safetail4 xs = tail xs

    safetail5
        = \ xs ->
          case xs of
            [] -> []
            (_ : xs) -> xs
