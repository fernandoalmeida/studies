module Conjunction where

    -- True && True = True
    -- _ && _ = False

    -- a && b = if a then if b then True else False else False

    -- a && b = if a then b else False

    a && b = if b then a else False
