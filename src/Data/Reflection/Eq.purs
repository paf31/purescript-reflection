module Data.Reflection.Eq
  ( ReflectedEq(..)
  , runReflectedEq
  , ReifiedEq(..)
  , reifiedEq
  , reifyEq
  ) where

import Prelude

import Data.Reflection (class Reifies, reify, reflect)
import Type.Proxy (Proxy(..))

newtype ReflectedEq s a = ReflectedEq a

runReflectedEq :: forall s a. ReflectedEq s a -> a
runReflectedEq (ReflectedEq x) = x

newtype ReifiedEq a = ReifiedEq (a -> a -> Boolean)

reifiedEq :: forall a. ReifiedEq a -> a -> a -> Boolean
reifiedEq (ReifiedEq eq) = eq

instance reflectEq :: (Reifies s (ReifiedEq a)) => Eq (ReflectedEq s a) where
  eq (ReflectedEq x) (ReflectedEq y) =
    reifiedEq (reflect (Proxy :: Proxy s)) x y

reifyEq :: forall a r. (a -> a -> Boolean) -> (forall s. (Reifies s (ReifiedEq a)) => Proxy s -> r) -> r
reifyEq eq f = reify (ReifiedEq eq) f
