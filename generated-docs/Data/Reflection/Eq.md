## Module Data.Reflection.Eq

#### `ReflectedEq`

``` purescript
newtype ReflectedEq s a
  = ReflectedEq a
```

##### Instances
``` purescript
(Reifies s (ReifiedEq a)) => Eq (ReflectedEq s a)
```

#### `runReflectedEq`

``` purescript
runReflectedEq :: forall s a. ReflectedEq s a -> a
```

#### `ReifiedEq`

``` purescript
newtype ReifiedEq a
  = ReifiedEq (a -> a -> Boolean)
```

#### `reifiedEq`

``` purescript
reifiedEq :: forall a. ReifiedEq a -> a -> a -> Boolean
```

#### `reifyEq`

``` purescript
reifyEq :: forall a r. (a -> a -> Boolean) -> (forall s. Reifies s (ReifiedEq a) => Proxy s -> r) -> r
```


