with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Direct_IO;
with Interfaces.C; use Interfaces.C;


package body GLV.Shaders is

   function Valid (Item : Shader) return Boolean is
   begin
      return glIsShader (GLuint (Item)) = GL_TRUE;
   end;

   function Compile_Status (Item : Shader) return Boolean is
      B : aliased GLint;
   begin
      glGetShaderiv (GLuint (Item), GL_COMPILE_STATUS, B'Access);
      return B = GL_TRUE;
   end;

   procedure Source (Item : Shader; Code : String) is
      C : aliased GLchar_array := To_C (Code);
      L : aliased GLint := C'Length;
   begin
      glShaderSource (GLuint (Item), 1, C'Access, L'Access);
   end;

   procedure Source_File (Item : Shader; Name : String) is
      File_Size : Natural := Natural (Size (Name));
      subtype File_String is String (1 .. File_Size);
      package File_String_IO is new Ada.Direct_IO (File_String);
      use File_String_IO;
      File      : File_Type;
      Content   : File_String;
   begin
      Open (File, In_File, Name);
      Read (File, Content);
      Close (File);
      Source (Item, Content);
   end;

   procedure Info (Item : Shader; Message : out String; Count : out Natural) is
      L : aliased GLsizei := 0;
      T : aliased GLchar_array (1 .. Message'Length);
   begin
      glGetShaderInfoLog (GLuint (Item), Message'Length, L'Access, T'Address);
      To_Ada (T, Message, Count);
   end;

   function Info (Item : Shader) return String is
      Text : String (1 .. 512);
      L : Natural := 0;
   begin
      Info (Item, Text, L);
      return Text (1 .. L);
   end;


   procedure Compile_Unchecked (Item : Shader) is
   begin
      glCompileShader (GLuint (Item));
   end;


   procedure Compile (Item : Shader) is
   begin
      Compile_Unchecked (Item);
      if not Compile_Status (Item) then
         raise Program_Error with Info (Item);
      end if;
   end;

   procedure Compile_Source (Item : Shader; Src : String) is
   begin
      Source (Item, Src);
      Compile (Item);
   end;

   procedure Compile_File (Item : Shader; Src : String) is
   begin
      Source_File (Item, Src);
      Compile (Item);
   end;





   function Create (Shade : Kind) return Shader is
   begin
      return Shader (glCreateShader (Shade'Enum_Rep));
   end;

   function Create_From_Source (Shade : Kind; Src : String) return Shader is
   begin
      return S : Shader := Create (Shade) do
         Compile_Source (S, Src);
      end return;
   end;

   function Create_From_File (Shade : Kind; Name : String) return Shader is
   begin
      return S : Shader := Create (Shade) do
         Compile_File (S, Name);
      end return;
   end;

end;
