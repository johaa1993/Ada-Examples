with Ada.Text_IO;

package body Bounded_Strings is

   function Create (S : String) return Bounded_String is
      B : Bounded_String (S'Length);
   begin
      B.Data := S;
      B.Last := S'Length;
      return B;
   end;


   procedure Append (Item : out Bounded_String; Str : String) is
   begin
      Item.Data (Item.Last + 1 .. Item.Last + Str'Length) := Str;
      Item.Last := Item.Last + Str'Length;
   end;

   function To_String (Item : Bounded_String) return String is
   begin
      return Item.Data (1 .. Item.Last);
   end;

   procedure Set (Item : out Bounded_String; Str : String) is
   begin
      Item.Data (1 .. Str'Length) := Str;
      Item.Last := Str'Length;
   end;


   procedure Get_Line (Item : out Bounded_String) is
      use Ada.Text_IO;
   begin
      Get_Line (Item.Data, Item.Last);
   end;

   procedure Put_Line (Item : Bounded_String) is
      use Ada.Text_IO;
   begin
      Put_Line (To_String (Item));
   end;

   procedure Put (File : Ada.Text_IO.File_Type; Item : Bounded_String) is
      use Ada.Text_IO;
   begin
      Put (File, To_String (Item));
   end;

   procedure Decrement (Item : in out Bounded_String; Amount : Natural) is
   begin
      Item.Last := Item.Last - Amount;
   end;




end;
