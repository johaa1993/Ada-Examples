with Ada.Text_IO;
with GNAT.Memory_Dump;
with System.Aux_DEC;
with Ada.Numerics.Discrete_Random;

procedure Main is

   subtype Integer_5_7 is Integer range 5 .. 7;
   package Integer_5_7_Random is new Ada.Numerics.Discrete_Random (Integer_5_7);
   G : Integer_5_7_Random.Generator;
   
   
   use Ada.Text_IO;
   use System.Aux_DEC;
   
   type String_Access is access all String;
   
   procedure Test (S : String_Access) is
   begin
      Put_Line (S'First'Img);
      Put_Line (S'Last'Img);
   end;

   String_Access_0 : String_Access;
   
   C1 : Character;
   C2 : Character;
   
begin
   loop
      
      Get_Immediate (C1);
      Get_Immediate (C2);
      
      declare
         String_0 : String (Integer'Value ("" & C1) .. Integer'Value ("" & C2)) := (others => 'Q');
         Int : aliased Integer;
      begin
         String_Access_0 := Int'Unchecked_Access;
         GNAT.Memory_Dump.Dump (String_Access_0.all'Address - 200, 700);
         Test (String_Access_0);
      end;
      
   end loop;
end;
