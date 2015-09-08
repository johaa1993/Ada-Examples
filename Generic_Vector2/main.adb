with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is

   generic
      type Number is private;
      type Vector is array (Integer range <>) of Number;
      with function "+" (A, B : Number) return Number is <>;
   package Generic_Vectors is
      function "+" (A, B: Vector) return Vector with
        Pre => A'First = B'First and A'Last = B'Last;
   end Generic_Vectors;

   package body Generic_Vectors is

      function "+" (A, B: Vector) return Vector is
         R : Vector (A'Range);
      begin
         for I in R'Range loop
            R(I) := A(I) + B(I);
         end loop;
         return R;
      end;

   end Generic_Vectors;


   type Integer_Vector is array (Integer range <>) of Integer;
   type Float_Vector is array (Integer range <>) of Float;


   procedure Put (X : Integer_Vector) is
   begin
      for E of X loop
         Put (E, 3);
      end loop;
   end;


   procedure Put (X : Float_Vector) is
   begin
      for E of X loop
         Put (E, 3, 3, 0);
      end loop;
   end;


   package Integer_Vectors is new Generic_Vectors (Integer, Integer_Vector);
   package Float_Vectors is new Generic_Vectors (Float, Float_Vector);

   use Integer_Vectors;
   use Float_Vectors;


   X : Integer_Vector := (4, 2);
   Y : Float_Vector := (1.3, 3.7);


begin

   Put (X);
   Put ("  +");
   Put (X);
   Put ("  =");
   X := X + X;
   Put (X);

   New_Line;
   Put (Y);
   Put ("  +");
   Put (Y);
   Put ("  =");
   Y := Y + Y;
   Put (Y);

end;
