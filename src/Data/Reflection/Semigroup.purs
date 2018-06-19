module Data.Reflection.Semigroup
  ( ReflectedSemigroup(..)
  , runReflectedSemigroup
  , ReifiedSemigroup(..)
  , reifiedAppend
  , reifySemigroup
  , reifySemigroup'
  ) where

import Prelude

import Data.Reflection (class Reifies, reify, reflect)
import Type.Proxy (Proxy(..))

newtype ReflectedSemigroup s a = ReflectedSemigroup a

runReflectedSemigroup :: forall s a. ReflectedSemigroup s a -> a
runReflectedSemigroup (ReflectedSemigroup a) = a

newtype ReifiedSemigroup a = ReifiedSemigroup (a -> a -> a)

reifiedAppend :: forall a. ReifiedSemigroup a -> a -> a -> a
reifiedAppend (ReifiedSemigroup append) = append

instance reflectSemigroup :: (Reifies s (ReifiedSemigroup a)) => Semigroup (ReflectedSemigroup s a) where
  append (ReflectedSemigroup a1) (ReflectedSemigroup a2) =
    ReflectedSemigroup $ reifiedAppend ((reflect :: Proxy s -> ReifiedSemigroup a) Proxy) a1 a2

reifySemigroup :: forall a r. (a -> a -> a) -> (forall s. (Reifies s (ReifiedSemigroup a)) => Proxy s -> r) -> r
reifySemigroup append f = reify (ReifiedSemigroup append) f

reifySemigroup' :: forall a. (a -> a -> a) -> (forall x. Semigroup x => (a -> x) -> x) -> a
reifySemigroup' append f = reify (ReifiedSemigroup append) go
  where
    go :: forall s. (Reifies s (ReifiedSemigroup a)) => Proxy s -> a
    go _ = runReflectedSemigroup (f (ReflectedSemigroup :: a -> ReflectedSemigroup s a))
