with Ada.Text_IO; use Ada.Text_IO;
with System; use System;
with System.Address_Image;

procedure Main is

   -- procedure House with Convention => Ada;
   procedure House is
   begin
      Put_Line( "Ding Dong" );
   end House;

   procedure Execute_Procedure (A : Address) is
      procedure P with Import, Convention => Ada, Address => A;
   begin
      P;
   end Execute_Procedure;

begin
   Put ("Executing ");
   Put_Line (System.Address_Image (House'Address));
   Execute_Procedure (House'Address);
end Main;
