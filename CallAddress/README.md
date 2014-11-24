# Description
Example on how to create a callable from type `System.Address`.

```ada
procedure TheProcedure with Import, Convention => Ada, Address => TheAddress;
```

The keyword `Convention` is a requirement and is telling the compiler how to interpret the address.