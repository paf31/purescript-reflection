module Data.Reflection
  ( class Reifies
  , reflect
  , reify
  ) where

import Prelude

import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)

-- | This class reifies a value of type `a` at the type level.
-- |
-- | `reflect` can be used to recover the value inside a function passed
-- | to `reify`.
class Reifies s a | s -> a where
  reflect :: Proxy s -> a

-- | Reify a value of type `a` at the type level.
-- |
-- | The value can be recovered in the body of the lambda by using the `reflect` function.
reify :: forall a r. a -> (forall s. Reifies s a => Proxy s -> r) -> r
reify a f = coerce f { reflect: \_ -> a } Proxy where
  coerce :: (forall s. Reifies s a => Proxy s -> r) -> { reflect :: Proxy Unit -> a } -> Proxy Unit -> r
  coerce = unsafeCoerce
