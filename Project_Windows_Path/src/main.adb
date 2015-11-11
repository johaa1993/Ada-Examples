with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Direct_IO;
with GNAT.OS_Lib;
with Ada.Directories;

with Ada.Environment_Variables;
with Ada.Command_Line.Environment;

procedure Main is
   
   use Ada.Text_IO;
   use Ada.Integer_Text_IO;
   
   
   procedure Next_Path (Item : String; P : in out Natural) is
   begin
      for I in Item'Range loop
         exit when Item (I) = ';';
      end loop;
   end;

   
begin

   --Put_Line (Ada.Environment_Variables.Value ("PATH"));
   

   for I in 1 .. Ada.Command_Line.Environment.Environment_Count loop
      Put (I, 4);
      Put ("  ");
      Put (Ada.Command_Line.Environment.Environment_Value (I));
      New_Line;
   end loop;
   
   
end;
