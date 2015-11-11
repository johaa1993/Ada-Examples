with Ada.Strings.

package Separated_Strings is

--     type Seperated_String (Str : access String; Sep : Character) is record
--        P : Positive := 1;
--     end record;

   type Separated_String (Buffer : access String; Sep : Character) is tagged record
      Pointer : Positive := 1;
      Last : Natural := 0;
   end record;

   procedure Next (Item : in out Separated_String);
   function Next_String (Item : in out Separated_String) return String;
   function Next_Positive (Item : in out Separated_String) return Positive;
   function Next_Integer (Item : in out Separated_String) return Integer;
   function Exists (Item : Separated_String) return Boolean;
   function Get_String (Item : Separated_String) return String;

   procedure Get_Line (Item : in out Separated_String);

end;
