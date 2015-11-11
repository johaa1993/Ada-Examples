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

   generic
      Str : String;
      Sep : Character;
   package Separated_Strings is
      function Next return String;
   private
      P : Positive := Str'First;
   end;

   package body Separated_Strings is
      function Next return String is
      begin
         return Separated_String_Next (Str, Sep, P);
      end;
   end;




--     procedure Demo is
--        use Ada.Text_IO;
--        Line_2 : String (1 .. 100);
--        Line_2_Last : Natural;
--        Line : String (1 .. 100);
--        Line_Last : Natural;
--     begin
--        loop
--           Get_Line (Line, Line_Last);
--           declare
--              package Seperated_String is new Separated_Strings (Line (Line'First .. Line_Last), ' ');
--           begin
--              loop
--                 Get_Line (Line, Line_Last);
--                 Put_Line (Seperated_String.Next);
--              end loop;
--           end;
--        end loop;
--     end;


   type Separated_String_Iterator (Str : access String; Sep : Character) is record
      P : Positive := Str'First;
   end record;

   function Exists (Item : Separated_String_Iterator) return Boolean is
   begin
      return Item.P < Item.Str'Last;
   end;

   function Next (Item : in out Separated_String_Iterator) return String is
   begin
      return Separated_String_Next (Item.Str.all, Item.Sep, Item.P);
   end;

   procedure Demo_1 is
      use Ada.Text_IO;
      Str : String := ",,,Seperated,,,By,,Comma,,,";
      P : Positive := Str'First;
   begin
      while P < Str'Last loop
         Put_Line (Separated_String_Next (Str, ',', P));
      end loop;
   end;

   procedure Demo_2 is
      use Ada.Text_IO;
      Str : aliased String := ",,,Seperated,,,By,,Comma,,,";
      P : Separated_String_Iterator (Str'Access, ',');
   begin
      while Exists (P) loop
         Put_Line (Next (P));
      end loop;
   end;

begin

   Demo_2;

end;
