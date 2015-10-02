with Ada.Text_IO;
with Ada.Direct_IO;
with GNAT.OS_Lib;

procedure Main is
   
   procedure Read (Name : String) is
      use Ada.Text_IO;
      File : File_Type;
   begin
      Open (File, In_File, Name);
      while not End_Of_File (File) loop
         Put_Line (Get_Line (File));
      end loop;
      Close (File);
   end;
   
   System_Root : String := GNAT.OS_Lib.Getenv ("SystemRoot").all;
   
   
begin

   --Read ("windows-telemetry.csv");
   
   --Ada.Text_IO.Put_Line ();
   
   
   Read (System_Root & "\System32\drivers\etc\hosts");
   
   null;
   
end;
