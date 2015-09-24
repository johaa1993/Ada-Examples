with GL;
with Interfaces.C; use Interfaces.C;
with Ada.Text_IO; use Ada.Text_IO;

package body GLV.Shaders.Programs is

   function Create return Program is
   begin
      return Program (glCreateProgram.all);
   end;

   function Valid (Item : Program) return Boolean is
   begin
      return glIsProgram (GLuint (Item)) = GL_TRUE;
   end;


   function Status (Item : Program) return Boolean is
      S : aliased GLint;
   begin
      glGetProgramiv (GLuint (Item), GL_LINK_STATUS, S'Access);
      return S = GL_TRUE;
   end;


   procedure Info (Item : Program; Message : out String; Count : out Natural) is
      L : aliased GLsizei := 0;
      T : aliased GLchar_array (1 .. Message'Length);
   begin
      glGetProgramInfoLog (GLuint (Item), Message'Length, L'Access, T'Address);
      To_Ada (T, Message, Count);
      if Count /= Integer(L) then
         null;
      end if;
   end;


   function Info (Item : Program) return String is
      Text : String (1 .. 512);
      L : Natural := 0;
   begin
      Info (Item, Text, L);
      return Text (1 .. L);
   end;


   procedure Activate (Item : Program) is
   begin
      glUseProgram (GLuint (Item));
   end;


   procedure Attach (P : Program; S : Shader) is
   begin
      glAttachShader (GLuint (P), GLuint (S));
   end;


   procedure Attach_From_Source (Item : Program; Shade : Shaders.Kind; Src : String) is
      S : Shader := Create_From_Source (Shade, Src);
   begin
      Attach (Item, S);
   end;

   procedure Attach_From_File (Item : Program; Shade : Shaders.Kind; Name : String) is
      S : Shader := Create_From_File (Shade, Name);
   begin
      Attach (Item, S);
   end;

   procedure Link_Unchecked (Item : Program) is
   begin
      glLinkProgram (GLuint (Item));
   end;

   procedure Link (Item : Program) is
   begin
      Link_Unchecked (Item);
      if not Status (Item) then
         null;
         raise Program_Error with "Link Error:" & Info (Item);
      end if;
   end;


end;
