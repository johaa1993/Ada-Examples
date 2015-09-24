with GL; use GL;

package GLV.Shaders.Programs is

   type Program (<>) is limited private;

   function Create return Program;

   function Valid (Item : Program) return Boolean;

   function Status (Item : Program) return Boolean with
     Pre => Valid (Item);

   function Info (Item : Program) return String with
     Pre => Valid (Item),
     Post => Info'Result'Length > 0;

   procedure Activate (Item : Program) with
     Pre => Valid (Item);

   procedure Attach (P : Program; S : Shader) with
     Pre => Valid (P);

   procedure Attach_From_Source (Item : Program; Shade : Shaders.Kind; Src : String) with
     Pre => Valid (Item);

   procedure Attach_From_File (Item : Program; Shade : Shaders.Kind; Name : String) with
     Pre => Valid (Item);

   procedure Link_Unchecked (Item : Program) with
     Pre => Valid (Item);

   procedure Link (Item : Program) with
     Pre => Valid (Item);

private

   use type GLuint;
   use type GLint;

   type Program is new GLuint range 1 .. GLuint'Last;

end;
