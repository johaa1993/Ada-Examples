with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with System.Storage_Elements; use System.Storage_Elements;
with Ada.Assertions; use Ada.Assertions;
with Ada.Command_Line; use Ada.Command_Line;

procedure Main is

   function Get_Argument_1 return Natural is
   begin
      return Natural'Value (Argument (1));
   exception
      when others => raise Program_Error with "Missing natural argument(1)";
   end;
   
   -- Change this size to see what happens for every address aligment under 64.
   Float_Array_Size : Natural := Get_Argument_1;
   type Float_Array is array (Integer range 1 .. Float_Array_Size) of Float;
   
   F4 : Float_Array;
   for F4'Alignment use 4;
   F8 : Float_Array;
   for F8'Alignment use 8;
   F16 : Float_Array;
   for F16'Alignment use 16;
   F32 : Float_Array;
   for F32'Alignment use 32;
   F64 : Float_Array;
   for F64'Alignment use 64;
   
begin

   -- Check if a 4 aligned address could be a 64 aligned.
   Put (Integer(To_Integer(F4'Address) mod 64));
   -- Sometimes it is, sometimes not, depends partly of Float_Array_Size.
   New_Line;
   Put (Integer(To_Integer(F8'Address) mod 64));
   New_Line;
   Put (Integer(To_Integer(F16'Address) mod 64));
   New_Line;
   Put (Integer(To_Integer(F32'Address) mod 64));
   New_Line;
   Put (Integer(To_Integer(F64'Address) mod 64));
   
   -- Lets see if the address is aligned to 64 storage units.
   Assert (Integer(To_Integer(F64'Address) mod 64) = 0);
   
end;
