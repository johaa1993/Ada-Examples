with Ada.Text_IO;


procedure Main is
   
   use Ada.Text_IO;
   type Matrix_2_3 is array (0 .. 1, 0 .. 2) of Natural;
   A : Matrix_2_3 := ((10, 20, 30), (400, 500, 600));
   
begin
   
   for E of A loop
      E := E + 1;
   end loop;
   
end Main;
