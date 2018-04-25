module Data.Reflection.Ord
  ( ReflectedOrd(..)
  , runReflectedOrd
  , ReifiedOrd(..)
  , reifiedEq
  , reifiedCompare
  , reifyOrd
  ) where

import Prelude (class Eq, class Ord, Ordering(..))
import Data.Reflection (class Reifies, reify, reflect)
import Type.Proxy (Proxy(..))

newtype ReflectedOrd s a = ReflectedOrd a

runReflectedOrd :: forall s a. ReflectedOrd s a -> a
runReflectedOrd (ReflectedOrd x) = x

data ReifiedOrd a = ReifiedOrd (a -> a -> Boolean) (a -> a -> Ordering)

reifiedEq :: forall a. ReifiedOrd a -> a -> a -> Boolean
reifiedEq (ReifiedOrd eq _) = eq

reifiedCompare :: forall a. ReifiedOrd a -> a -> a -> Ordering
reifiedCompare (ReifiedOrd _ compare) = compare

instance reflectEq :: (Reifies s (ReifiedOrd a)) => Eq (ReflectedOrd s a) where
  eq (ReflectedOrd x) (ReflectedOrd y) =
    reifiedEq (reflect (Proxy :: Proxy s)) x y

instance reflectOrd :: (Reifies s (ReifiedOrd a)) => Ord (ReflectedOrd s a) where
  compare (ReflectedOrd x) (ReflectedOrd y) =
    reifiedCompare (reflect (Proxy :: Proxy s)) x y

reifyOrd :: forall a r. (a -> a -> Ordering) -> (forall s. (Reifies s (ReifiedOrd a)) => Proxy s -> r) -> r
reifyOrd compare f = reify (ReifiedOrd eq compare) f
  where
    eq x y = case compare x y of
      EQ -> true
      _ -> false
