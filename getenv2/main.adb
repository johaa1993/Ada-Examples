with Interfaces.C;
with Interfaces.C.Pointers;
with Ada.Text_IO;
with Interfaces.C.Strings;
with System.Address_Image;
with Ada.Unchecked_Conversion;
with Interfaces.C_Streams;
with System.Storage_Elements;
with System.Address_To_Access_Conversions;
with GNAT.Memory_Dump;

procedure Main is

   use Ada.Text_IO;
   use System.Storage_Elements;
   use System;
   use Interfaces.C;
   --use Interfaces.C.Strings;

   function Get_Environment_Native (Name : Address) return Address with
     Import,
     Convention => C,
     External_Name => "getenv",
     Pre => Name /= Null_Address,
     Post => Get_Environment_Native'Result /= Null_Address;
   
   
   function Get_Environment (Name : char_array; Count : size_t) return char_array is
      Env : constant Address := Get_Environment_Native (Name (Name'First)'Address);
      Result : char_array (1 .. Count);
      for Result'Address use Env;
   begin
      return Result;
   end;

   subtype char_index is size_t;
   subtype Environment_Path_Index is char_index range 1 .. 100;
   type char_index_array is array (char_index range <>) of char_index;
   
   procedure Put (Item : char_array; Terminator : char) is
   begin
      for I in Item'Range loop
         exit when Item (I) = Terminator;
         Put (Character (Item (I)));
      end loop;
   end;
   
   procedure Put (Item : char_array; Terminator_1 : char; Terminator_2 : char) is
   begin
      for I in Item'Range loop
         exit when Item (I) = Terminator_1;
         exit when Item (I) = Terminator_2;
         Put (Character (Item (I)));
      end loop;
   end;
   
   procedure Locate (Item : char_array; Delimiter : char; Terminator : char; Result : out char_index_array) is
      J : char_index := 0;
   begin
      for I in Item'Range loop
         exit when Item (I) = Terminator;
         if Item (I) = Delimiter then
            Result (Result'First + J) := I;
            J := J + 1;
         end if;
      end loop;
   end;
   
   Result : char_array := Get_Environment ("PATH" & nul, 1024);
   Locations : char_index_array (1 .. 10);
   
begin
   
   Put (Result, nul);
   New_Line;
   Put (Result (Environment_Path_Index), ';');
   
   Locate (Result, ';', nul, Locations);
   
   New_Line;
   
   for I in Locations'Range loop
      Put (Locations (I)'Img & "  ");
      Put (Result (Locations (I) + 1 .. Result'Last), ';', nul);
      New_Line;
   end loop;
   
   
   null;
end;
