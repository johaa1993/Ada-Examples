with GL; use GL;

package GLV.Vertex_Arrays is

   -- The name "Vertex-array" is
   type Vertex_Array (<>) is limited private;

   -- Checks if the vertex array is bound.
   function Valid (Item : Vertex_Array) return Boolean;

   -- Returns unbound unique vertex array.
   function Generate return Vertex_Array;

   -- Vertex array should be bounded after the binding.
   procedure Bind (Item : Vertex_Array) with
   Post => Valid (Item);


private

   type Vertex_Array is new GLuint range 1 .. GLuint'Last;

end;
