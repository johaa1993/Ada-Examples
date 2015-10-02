with GL; use GL;

package GLV.Vertex_Arrays is

   type Vertex_Array is private;

   --glIsVertexArray.
   --Returns true if item is currently the name of a renderbuffer object.
   --Returns false if renderbuffer is zero.
   --Returns false if item is not the name of a renderbuffer object.
   --Returns false if an error occurs.
   --Returns false if item is returned by glGenVertexArrays and has not been bound by glBindVertexArray.
   function Valid (Item : Vertex_Array) return Boolean;

   --glGenVertexArrays.
   function Generate return Vertex_Array;

   --glBindVertexArray.
   procedure Bind (Item : Vertex_Array) with
   Post => Valid (Item);


private

   type Vertex_Array is new GLuint range 1 .. GLuint'Last;

end;
