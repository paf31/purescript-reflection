module Data.Reflection 
  ( Reifies
  , reflect
  , reify
  ) where

-- | This class reifies a value of type `a` at the type level.
-- |
-- | `reflect` can be used to recover the value inside a function passed
-- | to `reify`.
class Reifies a where
  reflect :: a

-- | Reify a value of type `a` at the type level.
-- |
-- | The value can be recovered in the body of the lambda by using the `reflect` function.
foreign import reify 
  "function reify(a) {\
  \  return function(run) {\
  \     return run({ reflect: a });\
  \  };\
  \}" :: forall a r. a -> (forall dummy. (Reifies a) => r) -> r

