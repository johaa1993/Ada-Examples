with Ada.Integer_Text_IO;

procedure Main is

   type Color is (Red, Orange, Yellow, Green, Blue, Violet);
   for Color use (Red => -4235,Orange => 0,Yellow => 1,Green => 6,Blue => 7,Violet => 4576345);
   
begin

   for I in Color loop
      Ada.Integer_Text_IO.Put(I'Enum_Rep);
   end loop;

   
end Main;
