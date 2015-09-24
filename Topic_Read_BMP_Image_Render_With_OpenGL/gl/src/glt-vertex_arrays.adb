with System; use System;
with GL;


package body GLT.Vertex_Arrays is

   function Valid (Item : Vertex_Array) return Boolean is
      use type glboolean;
   begin
      return glIsVertexArray (gluint (Item)) = GL_TRUE;
   end;

   function Generate return Vertex_Array is
      I : aliased GLuint;
   begin
      glGenVertexArrays (1, I'Access);
      return Vertex_Array (I);
   end;

   procedure Bind (Item : Vertex_Array) is
   begin
      glBindVertexArray (GLuint (Item));
   end;

end;
