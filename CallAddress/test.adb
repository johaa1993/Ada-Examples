with Ada.Text_IO;
with System;
with System.Address_Image;

procedure test is

   procedure House with Convention => C;
   procedure House is
   begin
      Ada.Text_IO.Put_Line( "Ding Dong" );
   end House;

   procedure ExecuteProcedureAddress( TheAddress : System.Address ) is
      procedure TheProcedure with Import, Convention => C, Address => TheAddress;
   begin
      TheProcedure;
   end ExecuteProcedureAddress;

begin
   Ada.Text_IO.Put_Line( System.Address_Image(House'Address) );
   ExecuteProcedureAddress( House'Address );
end test;
