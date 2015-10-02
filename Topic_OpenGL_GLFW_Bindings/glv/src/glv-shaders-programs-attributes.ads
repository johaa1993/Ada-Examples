with System; use System;
with System.Storage_Elements; use System.Storage_Elements;

package GLV.Shaders.Programs.Attributes is

   type Component is
     (
      Unsigned_Byte_Component,
      Float_Component
     );

   subtype Dimension is GLint range 1 .. 4;
   subtype Stride is GLsizei range 0 .. GLsizei'Last;
   type Normalization is (None_Normalization, True_Normalization);

   subtype Offset is Integer_Address range 0 .. Integer_Address'Last;

   type Attribute is private;

   function Count (Item : Program) return Natural;

   procedure Set (Item : Attribute; Size : Dimension; Comp : Component; Norm : Normalization; Strid : Stride; Pointer : Offset);
   procedure Set_Unsigned_Byte_4 (Item : Attribute; S : Stride; Pointer : Offset);
   procedure Set_Float_2 (Item : Attribute; S : Stride; Pointer : Offset);
   procedure Set_Float_3 (Item : Attribute; S : Stride; Pointer : Offset);
   procedure Set_Float_4 (Item : Attribute; S : Stride; Pointer : Offset);

   function Get (Item : Program; Name : String) return Attribute;


private

   for Component use
     (
      Unsigned_Byte_Component => GL_UNSIGNED_BYTE,
      Float_Component         => GL_FLOAT
     );

   for Component'Size use GLenum'Size;

   type Attribute is new GLuint range 0 .. GL_MAX_UNIFORM_LOCATIONS;
   for Normalization'Size use GLboolean'Size;
   for Normalization use (None_Normalization => GL_FALSE, True_Normalization => GL_TRUE);
end;
