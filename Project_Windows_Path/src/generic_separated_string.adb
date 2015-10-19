with Separated_String_Next;

package body Generic_Separated_String is
   function Current_Index return Natural is
   begin
      return Index;
   end;
   function Next_Index return Natural is
   begin
      return Index + 1;
   end;
   function Next return String is
   begin
      Index := Index + 1;
      return Separated_String_Next (Str, Sep, Pointer);
   end;
   procedure Next is
      Str : String := Next;
   begin
      null;
   end;
   function Exist return Boolean is
   begin
      return Pointer <= Str'Length;
   end;

   function Find_By_Index (I : Natural) return String is
   begin
      while Exist loop
         if Next_Index = I then
            return Next;
         end if;
         Next;
      end loop;
      return "";
   end;

end;
