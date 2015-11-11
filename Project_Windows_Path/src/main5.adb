with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Direct_IO;
with GNAT.OS_Lib;
with Ada.Directories;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Fixed;


with Separated_String_Index;
with Separated_String_Next;
with Separated_String_Jump;

with Ada.Strings;
with Ada.Containers;
with Ada.Strings.Hash;

with Bounded_Strings;


procedure Main is
   
   procedure Put_Separated_String (Str : String; Sep : Character) is
      use Ada.Text_IO;
      P : Positive := Str'First;
   begin
      while P < Str'Last loop
         Put_Line (Separated_String_Next (Str, ' ', p));
      end loop;
   end;
   
   function Separated_String_Next_Integer (Str : String; Sep : Character; P : in out Natural) return Integer is
      Str_Num : String := Separated_String_Next (Str, Sep, P);
   begin
      return Integer'Value (Str_Num);
   end;
   
   
   function Separated_String_Exclude (Str : String; Sep : Character; Index : Positive) return String is
      Count : Natural := 0;
      E : String := Separated_String_Index (Str, Sep, Index);
   begin
      return Str (Str'First .. E'First - 1) & Str (E'Last + 2 .. Str'Last);
   end;
   
   

   package Commands is
      type Command is
        (
         Remove_Command,
         Keep_Command,
         Import_File_Command,
         Export_File_Command,
         Show_Listed_Path_Command,
         Add_Command,
         None_Command,
         Show_Path_Command,
         Show_Bins_Command,
         Set_Path_Command,
         Get_Path_Command,
         Inspect_All_Command,
         Get_Input_Command
        );
      function Interpret (S : String) return Command;
   end;
   
   package body Commands is 
      function Interpret (S : String) return Command is
      begin
         if S = "remove" then
            return Remove_Command;
         elsif S = "keep" then
            return Keep_Command;
         elsif S = "show" then
            return Show_Listed_Path_Command;
         elsif S = "set" then
            return Set_Path_Command;
         elsif S = "get" then
            return Get_Path_Command;
         elsif S = "export" then
            return Export_File_Command;
         elsif S = "import" then
            return Import_File_Command;
         elsif S = "path" then
            return Show_Path_Command;
         elsif S = "inspect" then
            return Show_Bins_Command;
         elsif S = "add" then
            return Add_Command;
         elsif S = "inspect-all" then
            return Inspect_All_Command;
         else
            return None_Command;
         end if;
      end;
   end;
   
   
   
   
   procedure Demo is
      use Ada.Text_IO;
      use Commands;
      Com : Command := Get_Input_Command;
      Line : String (1 .. 100);
      Line_P : Positive;
      Line_Last : Natural;
      Line_Sep : constant Character := ' ';
      function Line_Next return String is (Separated_String_Next (Line (Line'First .. Line_Last), Line_Sep, Line_P));
      function Line_Next_Positive return Positive is (Positive'Value (Line_Next));
      function Line_Exists return Boolean is (Line_P < Line_Last);
      Winpath : String := "Hello;Banana;Okey;Orange";
      
   begin
      loop
         case Com is
            when Get_Input_Command =>
               Line_P := Line'First;
               Get_Line (Line, Line_Last);
               Com := Interpret (Line_Next);
            when Remove_Command =>
               Put_Line ("Remove_Command");
               
               Put (Separated_String_Exclude (Winpath, ';', Line_Next_Positive));
               
--                 declare
--                    S : String := Separated_String_Index (Winpath, ';', Line_Next_Positive);
--                 begin
--                    Put_Line (S);
--                    Put_Line (S'First'Img);
--                    Put_Line (S'Last'Img);
--                 end;
               
               
               Com := Get_Input_Command;
            when others =>
               Com := Get_Input_Command;
         end case;
      end loop;
   end;
   
   
   
begin
   
   Demo;
   
   null;
end;
