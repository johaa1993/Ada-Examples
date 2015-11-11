with Interfaces.C;
with Interfaces.C.Pointers;
with Ada.Text_IO;
with Interfaces.C.Strings;
with System.Address_Image;
with Ada.Unchecked_Conversion;
with Interfaces.C_Streams;
with System.Storage_Elements;
with System.Address_To_Access_Conversions;

procedure Main is

   use Ada.Text_IO;
   
   
   
   package Text is
      
      
      subtype Storage_Count is System.Storage_Elements.Storage_Count;
      subtype Address is System.Address;
      
      subtype Char is Interfaces.C.char;
      type Char_Access is access all Char;
      package Address_To_Char_Access_Conversion is new System.Address_To_Access_Conversions (Char);
      use Address_To_Char_Access_Conversion;
      
      subtype Int is Interfaces.C_Streams.int;
      type Int_Access is access all Int;
      package Address_To_Int_Access_Conversion is new System.Address_To_Access_Conversions (Int_Access);
      use Address_To_Int_Access_Conversion;
      
      Nul : constant Char := Interfaces.C.nul;
      
      type Char_Array is array (Integer range <>) of Char;
      
      type Buffer (Count : Natural) is record
         Data : Char_Array (1 .. Count);
         Last : Natural := 0;
      end record;
      
      procedure Append (Item : in out Buffer; Value : Char);

      
      use type System.Storage_Elements.Integer_Address;
      function Value_Char (Item : Address) return Char with Pre => System.Storage_Elements.To_Integer(Item) = 0;
      
      procedure Put (Item : Address);
      procedure Put (Item : Address; Terminator : Char; Max : Storage_Count);
      procedure Put_Move (Item : in out Address; Terminator : Char; Max : Storage_Count);
      procedure Increment (Item : in out Address);
      procedure Occurrence (Item : in out Address; Needle : Char; Terminator : Char; Max : Storage_Count);
      
      function Get_Environment (S : String) return Address with Import, Convention => C, External_Name => "getenv";

      --function Get_Environment (S : String) return Address;
      --pragma Import (C, Get_Environment, "getenv");
      
   end;
   
   package body Text is
      
      procedure Append (Item : in out Buffer; Value : Char) is
      begin
         Item.Last := Item.Last + 1;
         Item.Data (Item.Last) := Value;
      end;
      
      function Value_Char (Item : Address) return Char is
         --function Convert is new Ada.Unchecked_Conversion (Address, Char_Access);
         R : Address_To_Char_Access_Conversion.Object_Pointer := Address_To_Char_Access_Conversion.To_Pointer (Item);
      begin
         return R.all;
      end;
      
      function Value_Int (Item : Address) return Int is
         function Convert is new Ada.Unchecked_Conversion (Address, Int_Access);
      begin
         return Convert (Item).all;
      end;
      
      procedure Increment (Item : in out Address) is
         use type Storage_Count;
      begin
         Item := Item + 1;
      end;
      
      procedure Put (Item : Address) is
         --use Interfaces.C_Streams;
         --R : Int;
      begin
         --Ada.Text_IO.p
         --Ada.Text_IO.Put (Character(Value (Item)));
         --R := fputc (Value (Item), stdout);
         null;
      end;
      
      procedure Put_Move (Item : in out Address; Terminator : char; Max : Storage_Count) is
         use type Storage_Count;
         use type Address;
         use type Char;
         Max_Item : constant Address := Item + Max - 1;
      begin
         while Item /= Max_Item and then Value_Char (Item) /= Terminator loop
            Put (Item);
            Increment (Item);
         end loop;
      end;
      
      procedure Put (Item : Address; Terminator : char; Max : Storage_Count) is
         use Interfaces.C_Streams;
         P : Address := Item;
      begin
         Put_Move (P, Terminator, Max);
      end;
      
      procedure Occurrence (Item : in out Address; Needle : char; Terminator : char; Max : Storage_Count) is
         use type Storage_Count;
         use type Address;
         use type Char;
         Max_Item : constant Address := Item + Max - 1;
      begin
         while Item /= Max_Item and then Value_Char (Item) /= Terminator and then Value_Char (Item) /= Needle loop
            Increment (Item);
         end loop;
      end;
      
   end;
   
   E : Text.Address := Text.Get_Environment ("PATH");
   
   
   procedure Put_List (Item : in out Text.Address) is
      use Text;
   begin
      --return;
      loop
         case Value_Char (Item) is
         when Nul =>
            exit;
         when ';' =>
            New_Line;
         when others =>
            null;
            Put (Item);
         end case;
         Increment (Item);
      end loop;
   end;
   
   
   procedure Put_List_2 (Item : in out Text.Address; Buffer : in out Text.Buffer; Index : Positive) is
      use Text;
      Counter : Natural := 0;
   begin
      loop 
         case Value_Char (Item) is
         when Nul =>
            exit;
         when ';' =>
            Counter := Counter + 1;
         when others =>
            null;
         end case;
         if Index = Counter then
            Append (Buffer, Value_Char (Item));
         end if;
         Increment (Item);
      end loop;
   end;
   
   E1 : Text.Address := Text.Get_Environment ("PATH");
   E2 : Text.Address := Text.Get_Environment ("PATH");
   E3 : Text.Address := Text.Get_Environment ("PATH");
   E4 : Text.Address := Text.Get_Environment ("PATH");
   
   E5 : Text.Char := Text.Value_Char (E1);
   
begin
   Put_Line (System.Address_Image (E1));
   Put_Line (System.Address_Image (E2));
   Put_Line (System.Address_Image (E3));
   Put_Line (System.Address_Image (E4));
   
   --Put_List (E4);
   
   --Text.Put (E, Text.Nul, 500);
   --delay 1.0;
   --Text.Put (E, Text.Nul, 500);
   --New_Line;
   --Put_List (e);

   --Text.Put (e);
   --New_Line;
   --Text.Occurrence (e, ';', 3);
   --Text.Put (e);

   
   null;
end;
