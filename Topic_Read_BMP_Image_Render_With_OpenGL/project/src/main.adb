with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
with Ada.Float_Text_IO;
with Interfaces.C.Strings;
with Interfaces.C;
with System; use System;
with System.Address_Image;

with GL;
with GL.Init;
with GLFW;
with Interfaces;
with Ada.Streams.Stream_IO;
with Ada.Directories;
with Ada.Direct_IO;

with Bitmaps;
with Bitmaps.Put_Image;

with GLT.Shaders.Programs.Attributes;
with GLT.Shaders.Programs;
with GLT.Shaders;
with GLT.Buffers;
with GLT.Vertex_Arrays;

use GL;
use GLFW;
use Interfaces.C.Strings;
use Ada.Exceptions;

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
      use GLT.Vertex_Arrays;
      use GLT.Shaders.Programs.Attributes;
      use GLT.Buffers;
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
      Allocate (Array_Buffer_Target, Vertices'Size / Storage_Unit, Static_Draw_Mode);
      Write (Array_Buffer_Target, 0, Vertices'Size / Storage_Unit, Vertices'Address);
      glEnableVertexAttribArray (0);
      glVertexAttribPointer (0, 3, GL_FLOAT, GL.GL_FALSE, 8 * 4, System'To_Address (0 * 4));
      glEnableVertexAttribArray (1);
      glVertexAttribPointer (1, 3, GL_FLOAT, GL.GL_FALSE, 8 * 4, System'To_Address (3 * 4));
      glEnableVertexAttribArray (2);
      glVertexAttribPointer (2, 2, GL_FLOAT, GL.GL_FALSE, 8 * 4, System'To_Address (6 * 4));
   end;



   procedure Setup_Shader is
      use GLT.Shaders;
      use GLT.Shaders.Programs;
      P : Program := Create;
   begin
      Attach_From_File (P, Vertex_Shader, "shader.glvs");
      Attach_From_File (P, Fragment_Shader, "shader.glfs");
      Link (P);
      Activate (P);
   end;

   Window : GLFWwindow;

begin

   Start_Window (Window);

   declare
      use GLT.Buffers;
      B : Buffer := Generate;
   begin
      Setup_Shader;
      Bind (Array_Buffer_Target, B);
      Setup_Vertices;
   end;


   Read_Image ("lena512.bmp");




   Main_Loop (Window);



end;
