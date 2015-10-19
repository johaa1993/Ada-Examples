generic
   Str : String;
   Sep : Character;
package Generic_Separated_String is
   function Next return String;
   procedure Next;
   function Exist return Boolean;
   function Current_Index return Natural;
   function Next_Index return Natural;
   function Find_By_Index (I : Natural) return String;
private
   Pointer : Positive := 1;
   Index : Natural := 0;
end;
