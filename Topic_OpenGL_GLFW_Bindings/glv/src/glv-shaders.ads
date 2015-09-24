with GL; use GL;

package GLV.Shaders is

   type Kind is (Fragment_Shader, Vertex_Shader);

   type Shader (<>) is limited private;

   function Valid (Item : Shader) return Boolean;

   function Compile_Status (Item : Shader) return Boolean with
     Pre => Valid (Item);

   procedure Source (Item : Shader; Code : String) with
     Pre => Valid (Item) and Code'Length > 0;

   procedure Source_File (Item : Shader; Name : String) with
     Pre => Valid (Item) and Name'Length > 0;

   function Info (Item : Shader) return String with
     Pre => Valid (Item),
     Post => Info'Result'Length > 0;

   procedure Compile_Unchecked (Item : Shader) with
     Pre => Valid (Item);

   procedure Compile (Item : Shader) with
     Pre => Valid (Item);

   procedure Compile_Source (Item : Shader; Src : String) with
     Pre => Valid (Item);

   procedure Compile_File (Item : Shader; Src : String) with
     Pre => Valid (Item);

   function Create (Shade : Kind) return Shader with
     Post => Valid (Create'Result);

   function Create_From_Source (Shade : Kind; Src : String) return Shader with
     Post => Valid (Create_From_Source'Result);

   function Create_From_File (Shade : Kind; Name : String) return Shader with
     Post => Valid (Create_From_File'Result);


private

   use type GLint;
   use type GLuint;
   use type GLboolean;


   type Shader is new GLuint range 1 .. GLuint'Last;

   for Kind use (Fragment_Shader => GL_FRAGMENT_SHADER, Vertex_Shader => GL_VERTEX_SHADER);
   for Kind'Size use GLenum'Size;

end;
