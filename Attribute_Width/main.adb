with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure Main is

   type Enum is (Enum1, Enum2, Enum9999);
   -- Enum'Width returns a length which the discrete type requires to be represented as text.
   -- In this case Enum9999 is largest and has 8 characters so Enum'Width is 8.


   type Integer_Array is array (Enum) of Integer;

   X : Integer_Array := (others => 0);

begin

   for I in Enum loop
      Put (Head (I'Img, Enum'Width));
      Put ("|");
      Put (Tail (I'Img, Enum'Width));
      Put ("|");
      Put (X(I)'Img);
      New_Line;
   end loop;

end;
