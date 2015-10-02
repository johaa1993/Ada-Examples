with GLV.Colors;
with GLV.Float_Types;

package Vertices is

   type Vertex is record
      Position : GLV.Float_Types.Vector_3;
      Color : GLV.Colors.RGBA_ubyte;
   end record;

end;
