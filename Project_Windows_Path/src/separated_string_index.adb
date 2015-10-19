with Separated_String_Next;
with Separated_String_Jump;

function Separated_String_Index (Str : String; Sep : Character; I : Positive) return String is
   P : Positive := 1;
   C : Natural := 0;
begin
   while P <= Str'Length loop
      C := C + 1;
      if C = I then
         return Separated_String_Next (Str, Sep, P);
      else
         Separated_String_Jump (Str, Sep, P);
      end if;
   end loop;
   return "";
end;
