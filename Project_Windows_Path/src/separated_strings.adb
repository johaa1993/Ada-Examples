with Separated_String_Index;
with Separated_String_Next;
with Separated_String_Jump;
with Ada.Text_IO;

package body Separated_Strings is


   function Get_String (Item : Separated_String) return String is
   begin
      return Item.Buffer(Item.Buffer'First .. Item.Last);
   end;

   procedure Next (Item : in out Separated_String) is
   begin
      Separated_String_Jump (Get_String (Item), Item.Sep, Item.Pointer);
   end;

   function Next_String (Item : in out Separated_String) return String is
   begin
      return Separated_String_Next (Get_String (Item), Item.Sep, Item.Pointer);
   end;

   function Next_Positive (Item : in out Separated_String) return Positive is
   begin
      return Positive'Value (Next_String (Item));
   end;

   function Next_Integer (Item : in out Separated_String) return Integer is
   begin
      return Integer'Value (Next_String (Item));
   end;

   function Exists (Item : Separated_String) return Boolean is
   begin
      return Item.Pointer > Item.Last;
   end;

   procedure Get_Line (Item : in out Separated_String) is
      use Ada.Text_IO;
   begin
      Get_Line (Item.Buffer.all, Item.Last);
   end;

end;
