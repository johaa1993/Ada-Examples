with Interfaces.C; use Interfaces.C;
with System.Address_Image;

with Ada.Text_IO; use Ada.Text_IO;

package body GLV.Shaders.Programs.Uniforms is

   function Get (Item : Program; Name : String) return Uniform is
   begin
      return Uniform (glGetUniformLocation (GLuint (Item), To_C (Name)));
   end;

   procedure Set (Item : Uniform; Value : Matrix_4_Array) is
   begin
      glUniformMatrix4fv (GLint (Item), Value'Length, GL_FALSE, Value (Value'First)'Address);
   end;

   procedure Set (Item : Uniform; Value : Matrix_4) is
   begin
      glUniformMatrix4fv (GLint (Item), 1, GL_FALSE, Value'Address);
   end;


end;
