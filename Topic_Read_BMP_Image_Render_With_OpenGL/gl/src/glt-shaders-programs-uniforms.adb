with Interfaces.C; use Interfaces.C;
with System.Address_Image;

with Ada.Text_IO; use Ada.Text_IO;

package body GLT.Shaders.Programs.Uniforms is

   function Get (Item : Program; Name : String) return Uniform is
   begin
      return Uniform (GL.GetUniformLocation (GL.uint (Item), To_C (Name)));
   end;

   procedure Set (Item : Uniform; Value : Matrix4_Array) is
   begin
      GL.UniformMatrix4fv (GL.int (Item), Value'Length, GL.FALSE, Value (Value'First)'Address);
   end;

   procedure Set (Item : Uniform; Value : Matrix4) is
   begin
      GL.UniformMatrix4fv (GL.int (Item), 1, GL.FALSE, Value'Address);
   end;


end;
