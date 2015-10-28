with Separated_String_Next;

package body Separated_Strings is

   function Next (Item : in out Seperated_String) return String is
   begin
      return Separated_String_Next (Item.Str.all, Item.Sep, Item.P);
   end;

end;
