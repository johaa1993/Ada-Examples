with System; use System;

package GLT.Shaders.Programs.Attributes is

   type Component is (Float_Component);
   subtype Dimension is GLint range 1 .. 4;
   type Attribute is limited private;

   function Count (Item : Program) return Natural;

   procedure Set (Item : Attribute; Size : Dimension; C : Component; Normalized : GLboolean; Stride : GLsizei; Pointer : Address);

   procedure Set (Item : Program; Name : String; Size : Dimension; C : Component; Normalized : GLboolean; Stride : GLsizei; Pointer : Address);

   function Get (Item : Program; Name : String) return Attribute;


private


   for Component use (Float_Component => GL_FLOAT);
   for Component'Size use GLenum'Size;
   type Attribute is new GLuint range 0 .. GLuint'Last;

end;
