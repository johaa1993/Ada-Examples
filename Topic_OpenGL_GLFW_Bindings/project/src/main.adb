with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
with Ada.Float_Text_IO;

with GL;
with GL.Init;
with GLFW;

with GLV.Shaders.Programs.Attributes;
with GLV.Shaders.Programs;
with GLV.Shaders;
with GLV.Buffers;
with GLV.Vertex_Arrays;
with GLV.Windows;

with Setup_OpenGL;

procedure Main is

   use GL;
   use GLV.Windows;

   procedure Main_Loop (W : Window) is
   begin
      loop
         Pull_Events;
         glClear (GL_COLOR_BUFFER_BIT);
         Swap_Buffers (W);
         delay 0.1;
         exit when Closing (W);
      end loop;
   end;

   W : Window;
   A : GLV.Vertex_Arrays.Vertex_Array := GLV.Vertex_Arrays.Generate;

begin

   --GLV.Vertex_Arrays.Valid (A);
   Setup_OpenGL;
   W := Create (200, 200, "Title");
   Main_Loop (W);


end;
