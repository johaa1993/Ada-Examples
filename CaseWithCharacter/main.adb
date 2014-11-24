with Ada.Text_IO;
procedure Main is
   
   Input : Character;
   
begin
   
   TheLoop : loop
      Ada.Text_IO.Get_Immediate(Input);
      case Input is
      when 'a' =>
         Ada.Text_IO.Put_Line("left");
      when 'w' =>
         Ada.Text_IO.Put_Line("up");
      when 's' =>
         Ada.Text_IO.Put_Line("down");
      when 'd' =>
         Ada.Text_IO.Put_Line("right");
      when 'q' =>
         exit TheLoop;
      when others =>
         null;
      end case;
   end loop TheLoop;
   
end Main;
