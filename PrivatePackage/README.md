# What is private package?

## Abstract
Example of the difference between private package and non-private package.

## Code

```ada
package Parent is
   --declarations
end Parent;
```

```ada
package Parent.Child is
   --declarations
end Parent.Child;
```

```ada
private package Parent.PrivateChild is
   --declarations
end Parent.PrivateChild;
```

Allowed everywhere:
```ada
with Parent;
with Parent.Child;
```

Can only be acceded from the Parent family:
```ada
with Parent.PrivateChild;
```



## Build

```
gprbuild -P test_parent.gpr
gprbuild -P test_parentchild.gpr
gprbuild -P test_parentprivatechild.gpr
```