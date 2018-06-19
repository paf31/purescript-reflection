module Data.Reflection.Monoid
  ( ReflectedMonoid(..)
  , runReflectedMonoid
  , ReifiedMonoid(..)
  , reifiedMempty
  , reifiedMappend
  , reifyMonoid
  , reifyMonoid'
  ) where

import Prelude

import Data.Reflection (class Reifies, reify, reflect)
import Type.Proxy (Proxy(..))

newtype ReflectedMonoid s a = ReflectedMonoid a

runReflectedMonoid :: forall s a. ReflectedMonoid s a -> a
runReflectedMonoid (ReflectedMonoid a) = a

data ReifiedMonoid a = ReifiedMonoid a (a -> a -> a)

reifiedMempty :: forall a. ReifiedMonoid a -> a
reifiedMempty (ReifiedMonoid m _) = m

reifiedMappend :: forall a. ReifiedMonoid a -> a -> a -> a
reifiedMappend (ReifiedMonoid _ s) = s

instance reflectSemigroup :: (Reifies s (ReifiedMonoid a)) => Semigroup (ReflectedMonoid s a) where
  append (ReflectedMonoid a1) (ReflectedMonoid a2) =
    ReflectedMonoid $ reifiedMappend ((reflect :: Proxy s -> ReifiedMonoid a) Proxy) a1 a2

instance reflectMonoid :: (Reifies s (ReifiedMonoid a)) => Monoid (ReflectedMonoid s a) where
  mempty = ReflectedMonoid $ reifiedMempty ((reflect :: Proxy s -> ReifiedMonoid a) Proxy)

reifyMonoid :: forall a r. a -> (a -> a -> a) -> (forall s. (Reifies s (ReifiedMonoid a)) => Proxy s -> r) -> r
reifyMonoid empty append f = reify (ReifiedMonoid empty append) f

reifyMonoid' :: forall a. a -> (a -> a -> a) -> (forall x. Monoid x => (a -> x) -> x) -> a
reifyMonoid' empty append f = reify (ReifiedMonoid empty append) go
  where
    go :: forall s. (Reifies s (ReifiedMonoid a)) => Proxy s -> a
    go _ = runReflectedMonoid (f (ReflectedMonoid :: a -> ReflectedMonoid s a))
