with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;


procedure Main is


   subtype F is Float digits 2;
   
   A : F := 2.0;
   B : F := 0.02;
   
begin

   Put (A + B, 3, 3, 0);
   
   New_Line;
   
   Put (F'Digits);
   
end;
