module Test.Main where

import Prelude
import Data.Reflection

import Control.Monad.Eff
import Control.Monad.Eff.Console

newtype S a = S a

runS :: forall a. S a -> a
runS (S a) = a

newtype SemigroupDict a = SemigroupDict (a -> a -> a)

runSemigroupDict :: forall a. SemigroupDict a -> a -> a -> a
runSemigroupDict (SemigroupDict mappend) = mappend

instance reflectSemigroup :: (Reifies (SemigroupDict a)) => Semigroup (S a) where
  append (S a1) (S a2) = S $ mappend a1 a2
    where
    mappend = runSemigroupDict reflect

main :: Eff (console :: CONSOLE) Unit
main = reify dict do
  print $ runS $ S 1 <> S 2 <> S 3
  where
  dict :: SemigroupDict Int
  dict = SemigroupDict (+)
