with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Assertions; use Ada.Assertions;

procedure Main is

   
   type Integer_Array is array (Integer range <>) of Integer;
   
   function Dot (A : Integer_Array; B : Integer_Array) return Integer is
      R : Integer := 0;
   begin
      for I in A'Range loop
         R := R + A(I) * B(I);
      end loop;
      return R;
   end;

   R : Integer := Dot ((2, 4), (4, 3));
   
begin

   Assert (R = 20);
   Put (R);
   
end;
