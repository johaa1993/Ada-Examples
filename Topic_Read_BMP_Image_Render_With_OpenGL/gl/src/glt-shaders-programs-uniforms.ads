with System; use System;
with GLT.Float_Types; use GLT.Float_Types;

package GLT.Shaders.Programs.Uniforms is

   --A uniform is a global GLSL variable declared with the "uniform" storage qualifier.
   --These act as parameters that the user of a shader program can pass to that program.
   --They are stored in a program object.
   --Uniforms are so named because they do not change from one execution of a shader program to the next within a particular rendering call.
   --This makes them unlike shader stage inputs and outputs, which are often different for each invocation of a program stage.
   type Uniform (<>) is limited private;


   --Returns the corresponding uniform of the current program object.
   function Get (Item : Program; Name : String) return Uniform with
     Pre =>
     Valid (Item) and then
     Name'Length > 0;


   --Specify the value of a uniform mat4 variable for the current program object.
   procedure Set (Item : Uniform; Value : Matrix4);


private

   type Uniform is new GL.int range 0 .. GL.int'Last;

end;
