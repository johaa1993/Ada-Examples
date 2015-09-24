with Interfaces.C; use Interfaces.C;


package body GLT.Shaders.Programs.Attributes is

   function Count (Item : Program) return Natural is
      N : aliased GLint;
   begin
      glGetProgramiv (GLuint (Item), GL_ACTIVE_ATTRIBUTES, N'Access);
      return Natural(N);
   end;

   procedure Set (Item : Attribute; Size : Dimension; C : Component; Normalized : GLboolean; Stride : GLsizei; Pointer : Address) is
   begin
      glVertexAttribPointer (GLuint (Item), Size, C'Enum_Rep, Normalized, Stride, Pointer);
      glEnableVertexAttribArray (GLuint (Item));
   end;

   procedure Set (Item : Program; Name : String; Size : Dimension; C : Component; Normalized : GLboolean; Stride : GLsizei; Pointer : Address) is
   begin
      Set (Get (Item, Name), Size, C, Normalized, Stride, Pointer);
   end;

   function Get (Item : Program; Name : String) return Attribute is
   begin
      return Attribute (glGetAttribLocation (GLuint (Item), To_C (Name)));
   end;

end;
