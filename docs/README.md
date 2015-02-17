# Module Documentation

## Module Data.Reflection

### Type Classes

#### `Reifies`

This class reifies a value of type `a` at the type level.

`reflect` can be used to recover the value inside a function passed
to `reify`.

    class Reifies a where
      reflect :: a


### Values

#### `reify`

Reify a value of type `a` at the type level.

The value can be recovered in the body of the lambda by using the `reflect` function.

    reify :: forall a r. a -> (forall dummy. (Reifies a) => r) -> r



