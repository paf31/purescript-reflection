module Test.Main where

import Data.Reflection

import Debug.Trace

newtype S a = S a

instance showS :: (Show a) => Show (S a) where
  show (S a) = "(S " ++ show a ++ ")"

newtype SemigroupDict a = SemigroupDict (a -> a -> a)

runSemigroupDict :: forall a. SemigroupDict a -> a -> a -> a
runSemigroupDict (SemigroupDict mappend) = mappend

instance reflectSemigroup :: (Reifies (SemigroupDict a)) => Semigroup (S a) where
  (<>) (S a1) (S a2) = S $ a1 `mappend` a2
    where
    mappend = runSemigroupDict reflect

main = reify dict do
  print $ S 1 <> S 2 <> S 3
  where
  dict :: SemigroupDict Number
  dict = SemigroupDict (+)
