with Ada.Text_IO;
procedure Main is

   generic
      type T is private;
      with function "+" (A, B : T) return T is <>;
   package Vectors2D is
      type Vector2D is
      function "+" (A, B: Vector2D) return Vector2D;
   end Vectors2D;

   package body Vectors2D is
      function "+" (A, B: Vector2D) return Vector2D is
         R : Vector2D;
      begin
         R.X := A.X + B.X;
         R.Y := A.Y + B.Y;
         return R;
      end;
   end Vectors2D;
   
   package IntegerVectors2D is new Vectors2D(Integer);
   package FloatVectors2D is new Vectors2D(Float);
   
   use IntegerVectors2D;
   use FloatVectors2D;
   
   IntegerVector : IntegerVectors2D.Vector2D := (4, 2);
   FloatVector : FloatVectors2D.Vector2D := (1.3, 3.7);
begin

   IntegerVector := IntegerVector + IntegerVector;
   FloatVector := FloatVector + FloatVector;
   
   Ada.Text_IO.Put_Line(IntegerVector.X'Img & IntegerVector.Y'Img);
   Ada.Text_IO.Put_Line(FloatVector.X'Img & FloatVector.Y'Img);
   
end Main;
