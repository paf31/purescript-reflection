module Test.Main where

import Prelude

import Data.Reflection.Monoid (reifyMonoid')
import Effect (Effect)
import Effect.Console (logShow)

-- | Build a custom `Monoid` for addition modulo n.
withBase :: Int -> (forall m. Monoid m => (Int -> m) -> m) -> Int
withBase n f = reifyMonoid' 0 (\a b -> (a + b) `mod` n) f

main :: Effect Unit
main = do
    logShow $ withBase 12 main'
    logShow $ withBase 24 main'
  where
    main' :: forall m. Monoid m => (Int -> m) -> m
    main' f = f 1 <> f 2 <> f 3 <> f 4 <> f 5 <> f 6
