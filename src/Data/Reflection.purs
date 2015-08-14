module Data.Reflection 
  ( Reifies
  , reflect
  , reify
  ) where

import Unsafe.Coerce

-- | This class reifies a value of type `a` at the type level.
-- |
-- | `reflect` can be used to recover the value inside a function passed
-- | to `reify`.
class Reifies a where
  reflect :: a

-- | Reify a value of type `a` at the type level.
-- |
-- | The value can be recovered in the body of the lambda by using the `reflect` function.
reify :: forall a r. a -> (forall dummy. (Reifies a) => r) -> r
reify a f = toDictFun f { reflect: a }
  where
  toDictFun :: (forall dummy. (Reifies a) => r) -> { reflect :: a } -> r
  toDictFun = unsafeCoerce
