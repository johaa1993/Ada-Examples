with Ada.Text_IO;
procedure Main is

   type Color is (Red, Orange, Yellow, Green, Blue, Violet);
   
begin

   for I in Color loop
      Ada.Text_IO.Put_Line(I'Img);
   end loop;
   
   Ada.Text_IO.New_Line;
   
   for I in Color'Range loop
      Ada.Text_IO.Put_Line(I'Img);
   end loop;
   
end Main;

--  RED
--  ORANGE
--  YELLOW
--  GREEN
--  BLUE
--  VIOLET
--  
--  RED
--  ORANGE
--  YELLOW
--  GREEN
--  BLUE
--  VIOLET
