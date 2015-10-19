with Ada.Text_IO;

package Bounded_Strings is

   type Bounded_String (Count : Natural) is record
      Data : String (1 .. Count) := (others => ' ');
      Last : Natural := 0;
   end record;

   function Create (S : String) return Bounded_String;
   procedure Append (Item : out Bounded_String; Str : String);
   function To_String (Item : Bounded_String) return String;
   procedure Set (Item : out Bounded_String; Str : String);

   procedure Get_Line (Item : out Bounded_String);
   procedure Put_Line (Item : Bounded_String);
   procedure Put (File : Ada.Text_IO.File_Type; Item : Bounded_String);

   procedure Decrement (Item : in out Bounded_String; Amount : Natural);




end;
