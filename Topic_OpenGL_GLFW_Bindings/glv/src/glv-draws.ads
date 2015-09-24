with GL; use GL;

package GLV.Draws is

   type Mode is (Triangles_Mode);

   subtype Index is GLint range 0 .. GLint'Last;
   subtype Count is GLsizei range 0 .. GLsizei'Last;

   procedure Draw_Arrays (Method : Mode; First : Index; Number : Count);

private

   for Mode use (Triangles_Mode => GL_TRIANGLES);
   for Mode'Size use GLenum'Size;

end;
