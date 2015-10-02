with Interfaces.C; use Interfaces.C;


package body GLV.Shaders.Programs.Attributes is

   function Count (Item : Program) return Natural is
      N : aliased GLint;
   begin
      glGetProgramiv (GLuint (Item), GL_ACTIVE_ATTRIBUTES, N'Access);
      return Natural(N);
   end;

   procedure Set (Item : Attribute; Size : Dimension; Comp : Component; Norm : Normalization; Strid : Stride; Pointer : Offset) is
   begin
      glVertexAttribPointer (GLuint (Item), Size, Comp'Enum_Rep, Norm'Enum_Rep, Strid, To_Address (Pointer));
      glEnableVertexAttribArray (GLuint (Item));
   end;

   procedure Set_Unsigned_Byte_4 (Item : Attribute; S : Stride; Pointer : Offset) is
   begin
      Set (Item, 4, Unsigned_Byte_Component, True_Normalization, S, Pointer);
   end;

   procedure Set_Float_2 (Item : Attribute; S : Stride; Pointer : Offset) is
   begin
      Set (Item, 2, Float_Component, None_Normalization, S, Pointer);
   end;


   procedure Set_Float_3 (Item : Attribute; S : Stride; Pointer : Offset) is
   begin
      Set (Item, 3, Float_Component, None_Normalization, S, Pointer);
   end;

   procedure Set_Float_4 (Item : Attribute; S : Stride; Pointer : Offset) is
   begin
      Set (Item, 4, Float_Component, None_Normalization, S, Pointer);
   end;

   function Get (Item : Program; Name : String) return Attribute is
   begin
      return Attribute (glGetAttribLocation (GLuint (Item), To_C (Name)));
   end;

end;
