## Module Data.Reflection.Semigroup

#### `ReflectedSemigroup`

``` purescript
newtype ReflectedSemigroup s a
  = ReflectedSemigroup a
```

##### Instances
``` purescript
(Reifies s (ReifiedSemigroup a)) => Semigroup (ReflectedSemigroup s a)
```

#### `runReflectedSemigroup`

``` purescript
runReflectedSemigroup :: forall s a. ReflectedSemigroup s a -> a
```

#### `ReifiedSemigroup`

``` purescript
newtype ReifiedSemigroup a
  = ReifiedSemigroup (a -> a -> a)
```

#### `reifiedAppend`

``` purescript
reifiedAppend :: forall a. ReifiedSemigroup a -> a -> a -> a
```

#### `reifySemigroup`

``` purescript
reifySemigroup :: forall a r. (a -> a -> a) -> (forall s. Reifies s (ReifiedSemigroup a) => Proxy s -> r) -> r
```

#### `reifySemigroup'`

``` purescript
reifySemigroup' :: forall a. (a -> a -> a) -> (forall x. Semigroup x => (a -> x) -> x) -> a
```


