with GL;
with GL.Init;
with GLFW;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Interfaces.C;
with System;
with System.Address_Image;

procedure Setup_OpenGL is

   use System;
   use Interfaces.C;
   use Ada.Text_IO;
   use GLFW;

   function Load (Name : String) return Address is
      use Ada.Strings.Fixed;
      Procedure_Name : char_array := Interfaces.C.To_C(Name);
      Procedure_Address : Address := glfwGetProcAddress (Procedure_Name);
      Column_1_Width : constant := 30;
   begin
      Put (Head (Name, Column_1_Width));
      Put (Address_Image (Procedure_Address));
      New_Line;
      return Procedure_Address;
   end;


   Result : int;
   Window : GLFWwindow;
   Title : char_array := "Hello";

begin

   Result := glfwInit;
   Window := glfwCreateWindow (200, 200, Title);
   glfwMakeContextCurrent (Window);
   Put_Line ("GL.Init");
   GL.Init (Load'Access);
   glfwDestroyWindow (Window);

end;
