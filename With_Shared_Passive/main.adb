with Ada.Text_IO; use Ada.Text_IO;
with Store;

procedure Main is
begin

   Store.Counter := Store.Counter + 1;

   loop
      Put_Line(Store.Counter'Img);
      delay 1.0;
   end loop;

end;
