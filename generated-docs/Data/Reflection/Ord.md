## Module Data.Reflection.Ord

#### `ReflectedOrd`

``` purescript
newtype ReflectedOrd s a
  = ReflectedOrd a
```

##### Instances
``` purescript
(Reifies s (ReifiedOrd a)) => Eq (ReflectedOrd s a)
(Reifies s (ReifiedOrd a)) => Ord (ReflectedOrd s a)
```

#### `runReflectedOrd`

``` purescript
runReflectedOrd :: forall s a. ReflectedOrd s a -> a
```

#### `ReifiedOrd`

``` purescript
data ReifiedOrd a
  = ReifiedOrd (a -> a -> Boolean) (a -> a -> Ordering)
```

#### `reifiedEq`

``` purescript
reifiedEq :: forall a. ReifiedOrd a -> a -> a -> Boolean
```

#### `reifiedCompare`

``` purescript
reifiedCompare :: forall a. ReifiedOrd a -> a -> a -> Ordering
```

#### `reifyOrd`

``` purescript
reifyOrd :: forall a r. (a -> a -> Boolean) -> (a -> a -> Ordering) -> (forall s. Reifies s (ReifiedOrd a) => Proxy s -> r) -> r
```


