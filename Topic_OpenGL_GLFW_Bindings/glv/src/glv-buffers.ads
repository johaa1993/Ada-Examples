with GL; use GL;
with System; use System;

package GLV.Buffers is

   type Target is (Array_Buffer_Target, Element_Array_Target);
   type Draw_Mode is (Static_Draw_Mode);
   type Buffer is limited private;

   subtype Size_Unit is GLsizeiptr;
   subtype Offset_Unit is GLintptr;

   function Generate return Buffer;

   function Valid (Item : Buffer) return Boolean;

   procedure Bind (T : Target; Item : Buffer) with
     Post => Valid (Item);

   procedure Allocate (T : Target; Size : Size_Unit; Mode : Draw_Mode);

   procedure Write (T : Target; Offset : Offset_Unit; Size : Size_Unit; Data : Address);



private

   for Target'Size use GLenum'Size;
   for Draw_Mode'Size use GLenum'Size;

   for Target use (Array_Buffer_Target => GL_ARRAY_BUFFER, Element_Array_Target => GL_ELEMENT_ARRAY_BUFFER);
   for Draw_Mode use (Static_Draw_Mode => GL_STATIC_DRAW);

   type Buffer is new GLuint range 1 .. GLuint'Last;


end;
