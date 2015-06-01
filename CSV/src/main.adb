with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with CSV; use CSV;

procedure Main is

   procedure Put_Row ( S : String; N : Natural; C : Character ) is
      R : Row := Create (S);
   begin
      for I in 1 .. N loop
         Put (Next (R, S, C)'Img);
         Put (R.A, 4);
         Put (R.P, 4);
         Put (" : ");
         Put (Get (R, S));
         New_Line;
      end loop;
   end;

   S : String (1 .. 100);
   L : Natural;
   N : Natural;
   C : Character;

begin

   loop
      New_Line (2);
      Put ("Separtor: ");
      Get_Immediate (C);
      Put (C'Img);
      New_Line;
      Put("Input: ");
      Get_Line (S, L);
      Put("Iterations: ");
      Get (N); Skip_Line;
      Put_Row (S (1 .. L), N, C);
   end loop;

end;
