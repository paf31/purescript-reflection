## Module Data.Reflection

#### `Reifies`

``` purescript
class Reifies s a where
  reflect :: Proxy s -> a
```

This class reifies a value of type `a` at the type level.

`reflect` can be used to recover the value inside a function passed
to `reify`.

#### `reify`

``` purescript
reify :: forall a r. a -> (forall s. Reifies s a => Proxy s -> r) -> r
```

Reify a value of type `a` at the type level.

The value can be recovered in the body of the lambda by using the `reflect` function.


