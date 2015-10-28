with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Direct_IO;
with GNAT.OS_Lib;
with Ada.Directories;

with Bounded_Strings;
use Bounded_Strings;

with Separated_String_Index;
with Separated_String_Next;
with Separated_String_Jump;

procedure Main is
   
   
   function Is_Natural (Str : String) return Boolean is
      subtype Natural_Character is Character range '0' .. '9';
   begin
      for C of Str loop
         if C not in Natural_Character then
            return False;
         end if;
      end loop;
      return True;
   end;
   
   type Boolean_Array is array (Integer range <>) of Boolean;
   type Positive_Array is array (Integer range <>) of Positive;
   

   procedure Separated_String_Masking_Prototype (Str : String; Sep : Character; B : Boolean_Array; Res : in out Bounded_String) is
      P : Positive := Str'First;
      C : Natural := 0;
   begin
      Set (Res, "");
      while P <= Str'Length loop
         if B (B'First + C) then
            Append (Res, Separated_String_Next (Str, Sep, P) & Sep);
         else
            Separated_String_Jump (Str, Sep, P);
         end if;
         C := C + 1;
      end loop;
      Decrement (Res, 1);
   end;
   
   
   
   procedure Walk_Directory (Directory : String; Pattern : String) is
      use Ada.Directories;
      use Ada.Text_IO;
      Search : Search_Type;
      Dir_Ent : Directory_Entry_Type;
   begin
      Start_Search (Search, Directory, Pattern);
      while More_Entries (Search) loop
         Get_Next_Entry (Search, Dir_Ent);
         Put_Line ("  " & Simple_Name (Dir_Ent));
      end loop;
      End_Search (Search);
   end Walk_Directory;
   
   
   
   
   procedure Walk_Directory_Inspect (Str : String) is
      P : Positive := Str'First;
      C : Natural := 0;
      procedure Next is
         use Ada.Integer_Text_IO;
         use Ada.Text_IO;
         Directory : String := Separated_String_Next (Str, ';', P);
      begin
         C := C + 1;
         Put (C, 2);
         Put (" ");
         Put (Directory);
         New_Line;
         Walk_Directory (Directory, "*.exe");
         New_Line (2);
      end;
   begin
      while P <= Str'Last loop
         Next;
      end loop;
   end;
   
   
   
   

   
   
   procedure Put_Seperated_String (Str : String; Sep : Character) is
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
      P : Positive := Str'First;
      C : Natural := 0;
   begin
      while P <= Str'Last loop
         C := C + 1;
         Put (C, 4);
         Put (" ");
         Put (Separated_String_Next (Str, Sep, P));
         New_Line;
      end loop;
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
         Get_User_Input_Line_Command
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
   
   
   package Arguments is
      Index : Natural := 0;
      function Next_String return String;
      function Next_Positive return Positive;
      procedure Jump;
      procedure Get;
      function Exists return Boolean;
   private
      P : Positive := 1;
      Line : Bounded_String (256);
   end;
   
   package body Arguments is
      function Next_String return String is
      begin
         Index := Index + 1;
         return Separated_String_Next (To_String (Line), ' ', P);
      end;
      function Next_Positive return Positive is
      begin
         return Positive'Value (Next_String);
      end;
      procedure Jump is
      begin
         Index := Index + 1;
         Separated_String_Jump (To_String (Line), ' ', P);
      end;
      procedure Get is
      begin
         Get_Line (Line);
         P := 1;
         Index := 0;
      end;
      function Exists return Boolean is
      begin
         return P <= To_String (Line)'Length;
      end;
   end;
   
   
   
   
   package Windows_Path is
      Index : Natural := 0;
      function Next return String;
      procedure Jump;
      procedure Get;
      function Exists return Boolean;
      procedure Masking (Mask : Boolean_Array);
      function To_String return String;
      procedure Append (Str : String);
   private
      P : Positive := 1;
      Path : Bounded_String (2048);
   end;
   
   package body Windows_Path is
      function Next return String is
      begin
         Index := Index + 1;
         return Separated_String_Next (To_String (Path), ';', P);
      end;
      procedure Jump is
      begin
         Index := Index + 1;
         Separated_String_Jump (To_String (Path), ';', P);
      end;
      procedure Get is
         use GNAT.OS_Lib;
      begin
         Set (Path, Getenv ("PATH").all);
         P := 1;
      end;
      function Exists return Boolean is
      begin
         return P <= To_String (Path)'Length;
      end;
      procedure Masking (Mask : Boolean_Array) is
      begin
         Separated_String_Masking_Prototype (To_String (Path), ';', Mask, Path);
      end;
      function To_String return String is
      begin
         return To_String (Path);
      end;
      procedure Append (Str : String) is
      begin
         Append (Path, ";" & Str);
      end;
   end;
   
   
   
   
   

   procedure Controller is
      use Commands;
      use GNAT.OS_Lib;
      use Ada.Text_IO;
      use Bounded_Strings;
      
      Keep : Boolean_Array (1 .. 128);
      Export_File : File_Type;
      Argument_P : Positive := 1;
      Argument_Sep : constant Character := ' ';
      Path_Sep : constant Character := ';';
      Com : Command := Get_User_Input_Line_Command;
      
   begin
      loop
         
         case Com is
         
         when Get_User_Input_Line_Command =>
            Arguments.Get;
            Com := Interpret (Arguments.Next_String);
            
         when Inspect_All_Command =>
            Walk_Directory_Inspect (Windows_Path.To_String);
            Com := Get_User_Input_Line_Command;
         
         when Remove_Command =>
            Keep := (others => True);
            while Arguments.Exists loop
               Keep (Arguments.Next_Positive) := False;
            end loop;
            Windows_Path.Masking (Keep);
            Com := Show_Listed_Path_Command;
            
         when Keep_Command =>
            Keep := (others => False);
            while Arguments.Exists loop
               Keep (Arguments.Next_Positive) := True;
            end loop;
            Windows_Path.Masking (Keep);
            Com := Show_Listed_Path_Command;
            
         when Add_Command =>
            Windows_Path.Append (Arguments.Next_String);
            Com := Show_Listed_Path_Command;
            
         when Set_Path_Command =>
            Put_Line ("Not supperted yet");
            Com := Show_Path_Command;
    
         when Get_Path_Command =>
            Windows_Path.Get;
            Com := Show_Listed_Path_Command;
            
         when Import_File_Command =>
            Put_Line ("Not supperted yet");
            Com := Get_User_Input_Line_Command;
            
         when Export_File_Command =>
            Create (Export_File, Out_File, Arguments.Next_String);
            Put (Export_File, Windows_Path.To_String);
            Close (Export_File);
            Com := Show_Path_Command;
            
         when Show_Path_Command =>
            Put_Line (Windows_Path.To_String);
            Com := Get_User_Input_Line_Command;
            
         when Show_Bins_Command =>
            --Put_Line (Separated_String_Index (To_String (Path), Path_Sep, Positive'Value (Argument_Next)));
            Walk_Directory (Separated_String_Index (Windows_Path.To_String, Path_Sep, Arguments.Next_Positive), "*.exe");
            Com := Get_User_Input_Line_Command;
            
         when Show_Listed_Path_Command =>
            Put_Seperated_String (Windows_Path.To_String, Path_Sep);
            Com := Get_User_Input_Line_Command;
            
         when others =>
            null;
            
         end case;
      end loop;
   end;

   
begin


   Controller;
   
   
end;
