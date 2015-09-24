with Ada.Text_IO; use Ada.Text_IO;

package body GLT.Buffers is


   function Generate return Buffer is
      Identity : aliased GLuint;
   begin
      glGenBuffers (1, Identity'Access);
      return Buffer (Identity);
   end;


   function Valid (Item : Buffer) return Boolean is
      use type GLboolean;
   begin
      return glIsBuffer (GLuint (Item)) = GL_TRUE;
   end;

   procedure Bind (T : Target; Item : Buffer) is
   begin
      glBindBuffer (T'Enum_Rep, GLuint (Item));
   end;

   procedure Allocate_And_Write (T : Target; Size : Size_Unit; Data : Address; Mode : Draw_Mode) is
   begin
      glBufferData (T'Enum_Rep, Size, Data, Mode'Enum_Rep);
   end;

   procedure Allocate (T : Target; Size : Size_Unit; Mode : Draw_Mode) is
   begin
      Allocate_And_Write (T, Size, Null_Address, Mode);
   end;

   procedure Write (T : Target; Offset : Offset_Unit; Size : Size_Unit; Data : Address) is
   begin
      glBufferSubData (T'Enum_Rep, Offset, Size, Data);
   end;


end;
