with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Direct_IO;
with GNAT.OS_Lib;
with Ada.Directories;

--  with Bounded_Strings;
--  use Bounded_Strings;
--  
--  with Separated_String_Index;
with Separated_String_Next;
--  with Separated_String_Jump;
--  with Separated_Strings;

procedure Main is
   
   function Separated_String_Next (Str : String; Sep : Character; P : in out Positive) return String is
      A : Positive := P;
      B : Positive;
   begin
      while A <= Str'Last and then Str(A) = Sep loop
         A := A + 1;
      end loop;
      P := A;
      while P <= Str'Last and then Str(P) /= Sep loop
         P := P + 1;
      end loop;
      B := P - 1;
      while P <= Str'Last and then Str(P) = Sep loop
         P := P + 1;
      end loop;
      return Str(A .. B);
   end;
   
   type Seperated_String (Str : access String; Separator : Character) is record
      Pointer : Positive := Str'First;
   end record;
   
   function Separated_String_Next (Sep_Str : in out Seperated_String) return String is
   begin
      return Separated_String_Next (Sep_Str.Str.all, Sep_Str.Separator, Sep_Str.Pointer);
   end;
   
   
   procedure Controller is
      use Ada.Text_IO;
      Str : aliased String (1 .. 100);
      Last : Natural;
      Sep_Str : Seperated_String := (Str'Unchecked_Access, ',', Str'First);
   begin
      loop
         --Get_Line (Line);
         --Put_Line (Line);
         null;
      end loop;
   end;

   
   
   
   
begin


   null;
   
   
end;
