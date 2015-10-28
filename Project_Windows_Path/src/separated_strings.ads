package Separated_Strings is

   type Seperated_String (Str : access String; Sep : Character) is record
      P : Positive := 1;
   end record;

  function Next (Item : in out Seperated_String) return String;

private



end;
