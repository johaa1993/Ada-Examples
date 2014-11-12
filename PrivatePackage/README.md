# What is private package?

## Abstract
Example of the difference between private package and non-private package.


```ada
private package Parent.PrivateChild is
   --declarations
end Parent.PrivateChild;
```


```ada
package Parent.Child is
   --declarations
end Parent.Child;
```

## Build

```
gprbuild -P test1.gpr
gprbuild -P test2.gpr
gprbuild -P test3.gpr
```
