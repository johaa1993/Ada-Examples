with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
with Ada.Float_Text_IO;
with Ada.Streams.Stream_IO;
with Ada.Directories;
with Ada.Direct_IO;

with System;
with System.Address_Image;

with Interfaces;
with Interfaces.C;
with Interfaces.C.Strings;

with GL;
with GL.Init;
with GLFW;

with Bitmaps;
with Bitmaps.Put_Image;

use GL;
use GLFW;
use System;

procedure Main is

   function Load (Name : String) return Address is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Interfaces.C;
      Procedure_Name : char_array := Interfaces.C.To_C(Name);
      Procedure_Address : Address := glfwGetProcAddress (Procedure_Name);
   begin
      Put (Head(Name, 30));
      Put (Address_Image(Procedure_Address));
      New_Line;
      return Procedure_Address;
   end;

   procedure Read_Image (Name : String) is
      use Ada.Streams.Stream_IO;
      use Bitmaps;
      use type Interfaces.Unsigned_32;
      File : File_Type;
      Streamer : Stream_Access;
      Bitmap : Bitmap_Header;
   begin
      Open (File, In_File, Name);
      Streamer := Stream (File);
      Bitmap_Header'Read (Streamer, Bitmap);
      Set_Index (File, Positive_Count (Bitmap.File.Offset));
      declare
         use Ada.Text_IO;
         type Pixel_Array is array (1 .. Bitmap.Information.Width * Bitmap.Information.Height) of Pixel_8_Grayscale;
         Image : Pixel_Array;
         Texture : aliased GLuint;
      begin
         Put_Line ("Bitmap");
         Put_Image (Bitmap);
         New_Line (2);
         Pixel_Array'Read (Streamer, Image);
         Close (File);
         glGenTextures (1, Texture'Access);
         glBindTexture (GL_TEXTURE_2D, Texture);
         glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
         glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
         --glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
         --glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );
         glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, GLint(Bitmap.Information.Width), GLint(Bitmap.Information.Height), 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, Image'Address);
      end;
   end;


   procedure Start_Window (Window : out GLFWwindow) is
      use Interfaces.C;
      use Ada.Text_IO;
      Title : char_array := "Hello";
      glfwInit_Result : int;
   begin
      Put_Line ("Start_Window");
      glfwInit_Result := glfwInit;
      Window := glfwCreateWindow (200, 200, Title);
      glfwMakeContextCurrent (Window);
      Put_Line ("GL.Init");
      GL.Init (Load'Access);
   end;


   procedure Main_Loop (Window : GLFWwindow) is
      use type Interfaces.C.int;
   begin
      loop
         glfwPollEvents;
         glClear (GL_COLOR_BUFFER_BIT);
         glDrawArrays (GL_TRIANGLES, 0, 6);
         glfwSwapBuffers (Window);
         delay 0.1;
         exit when glfwWindowShouldClose (Window) = 1;
      end loop;
   end;



   procedure Setup_Vertices is
      use type GLfloat;
      use type GLsizeiptr;
      use type GLsizei;
      Vertices : array(Positive range <>) of GLfloat :=
        (
         -1.0, -1.0, 0.0,     0.0, 0.0, 0.0,   0.0, 0.0,
         +1.0, +1.0, 0.0,     0.0, 0.0, 0.0,   1.0, 1.0,
         +1.0, -1.0, 0.0,     0.0, 0.0, 0.0,   1.0, 0.0,

         -1.0, -1.0, 0.0,     0.0, 0.0, 0.0,   0.0, 0.0,
         +1.0, +1.0, 0.0,     0.0, 0.0, 0.0,   1.0, 1.0,
         -1.0, +1.0, 0.0,     0.0, 0.0, 0.0,   0.0, 1.0
        );
   begin
      glBufferData (GL_ARRAY_BUFFER, Vertices'Size / Storage_Unit, Vertices'Address, GL_STATIC_DRAW);
      glEnableVertexAttribArray (0);
      glVertexAttribPointer (0, 3, GL_FLOAT, GL.GL_FALSE, 8 * 4, System'To_Address (0 * 4));
      glEnableVertexAttribArray (1);
      glVertexAttribPointer (1, 3, GL_FLOAT, GL.GL_FALSE, 8 * 4, System'To_Address (3 * 4));
      glEnableVertexAttribArray (2);
      glVertexAttribPointer (2, 2, GL_FLOAT, GL.GL_FALSE, 8 * 4, System'To_Address (6 * 4));
   end;


   procedure Shader_Source (Item : GLuint; Code : String) is
      use Interfaces.C;
      C : aliased GLchar_array := To_C (Code);
      L : aliased GLint := C'Length;
   begin
      glShaderSource (Item, 1, C'Access, L'Access);
   end;

   procedure Shader_Source_File (Item : GLuint; Name : String) is
      use Ada.Directories;
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
      Shader_Source (Item, Content);
   end;

   procedure Get_Shader_Info_Log (Item : GLuint; Message : out String; Count : out Natural) is
      use Interfaces.C;
      L : aliased GLsizei := 0;
      T : aliased GLchar_array (1 .. Message'Length);
   begin
      glGetShaderInfoLog (GLuint (Item), Message'Length, L'Access, T'Address);
      To_Ada (T, Message, Count);
   end;

   function Get_Shader_Info_Log (Item : GLuint) return String is
      Text : String (1 .. 512);
      L : Natural := 0;
   begin
      Get_Shader_Info_Log (Item, Text, L);
      return Text (1 .. L);
   end;

   procedure Get_Program_Info_Log (Item : GLuint; Message : out String; Count : out Natural) is
      use Interfaces.C;
      L : aliased GLsizei := 0;
      T : aliased GLchar_array (1 .. Message'Length);
   begin
      glGetProgramInfoLog (GLuint (Item), Message'Length, L'Access, T'Address);
      To_Ada (T, Message, Count);
   end;

   function Get_Program_Info_Log (Item : GLuint) return String is
      Text : String (1 .. 512);
      L : Natural := 0;
   begin
      Get_Program_Info_Log (Item, Text, L);
      return Text (1 .. L);
   end;

   function Link_Status (Item : GLuint) return Boolean is
      use type GLint;
      S : aliased GLint;
   begin
      glGetProgramiv (Item, GL_LINK_STATUS, S'Access);
      return S = GL_TRUE;
   end;

   function Compile_Status (Item : GLuint) return Boolean is
      use type GLint;
      B : aliased GLint;
   begin
      glGetShaderiv (Item, GL_COMPILE_STATUS, B'Access);
      return B = GL_TRUE;
   end;

   procedure Setup_Shader is
      use Ada.Text_IO;
      Program : GLuint := glCreateProgram.all;
      Vertex_Shader : GLuint := glCreateShader (GL_VERTEX_SHADER);
      Fragment_Shader : GLuint := glCreateShader (GL_FRAGMENT_SHADER);
   begin
      Put_Line ("Setup_Shader");
      Shader_Source_File (Vertex_Shader, "shader.glvs");
      Shader_Source_File (Fragment_Shader, "shader.glfs");
      glCompileShader (Vertex_Shader);
      glCompileShader (Fragment_Shader);
      if not Compile_Status (Vertex_Shader) then
         Put_Line (Get_Shader_Info_Log (Vertex_Shader));
      end if;
      if not Compile_Status (Fragment_Shader) then
         Put_Line (Get_Shader_Info_Log (Fragment_Shader));
      end if;
      glAttachShader (Program, Vertex_Shader);
      glAttachShader (Program, Fragment_Shader);
      glLinkProgram (Program);
      if not Link_Status (Program) then
         Put_Line (Get_Program_Info_Log (Fragment_Shader));
      end if;
      glUseProgram (Program);
   end;

   Window : GLFWwindow;
   Array_Buffer : aliased GLuint;
   Vertex_Array : aliased GLuint;

begin

   Start_Window (Window);
   Setup_Shader;
   glGenBuffers (1, Array_Buffer'Access);
   glGenVertexArrays (1, Vertex_Array'Access);
   glBindBuffer (GL_ARRAY_BUFFER, Array_Buffer);
   glBindVertexArray (Vertex_Array);
   Setup_Vertices;
   Read_Image ("lena512.bmp");
   Main_Loop (Window);

end;
