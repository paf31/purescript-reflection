## Module Data.Reflection.Monoid

#### `ReflectedMonoid`

``` purescript
newtype ReflectedMonoid s a
  = ReflectedMonoid a
```

##### Instances
``` purescript
(Reifies s (ReifiedMonoid a)) => Semigroup (ReflectedMonoid s a)
(Reifies s (ReifiedMonoid a)) => Monoid (ReflectedMonoid s a)
```

#### `runReflectedMonoid`

``` purescript
runReflectedMonoid :: forall s a. ReflectedMonoid s a -> a
```

#### `ReifiedMonoid`

``` purescript
data ReifiedMonoid a
  = ReifiedMonoid a (a -> a -> a)
```

#### `reifiedMempty`

``` purescript
reifiedMempty :: forall a. ReifiedMonoid a -> a
```

#### `reifiedMappend`

``` purescript
reifiedMappend :: forall a. ReifiedMonoid a -> a -> a -> a
```

#### `reifyMonoid`

``` purescript
reifyMonoid :: forall a r. a -> (a -> a -> a) -> (forall s. Reifies s (ReifiedMonoid a) => Proxy s -> r) -> r
```

#### `reifyMonoid'`

``` purescript
reifyMonoid' :: forall a. a -> (a -> a -> a) -> (forall x. Monoid x => (a -> x) -> x) -> a
```


