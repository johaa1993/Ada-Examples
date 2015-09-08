# Description
Procedure from `System.Address`.

```ada
procedure Procedure_From_Address with Import, Convention => Ada, Address => The_Address;
```

The keyword `Convention` is a requirement and is telling the compiler how to interpret the address.
The `Address` must be a `System.Address` type.
