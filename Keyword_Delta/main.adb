with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;


procedure Main is

   type F is delta 10.0 digits 3 range 0.0 .. 10.0;
   type G is delta 2.0 range 0.0 .. 1.0;
   
   
   F0 : F := 0.0;
   G0 : G := 1.99999;
   
begin

   Put ("F0   " & F0'Img);
   New_Line;
   Put ("Pred " & F'Pred(F0)'Img);
   New_Line;
   Put ("Succ " & F'Succ(F0)'Img);
   
   New_Line (2);
   
   Put ("G0   " & G0'Img);
   New_Line;
   Put ("Pred " & G'Pred(G0)'Img);
   New_Line;
   Put ("Succ " & G'Succ(G0)'Img);
   
end;
