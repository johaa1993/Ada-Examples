with Ada.Numerics.Generic_Real_Arrays;

with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Generic_Elementary_Functions;
with Mathpack.Generic_Quaternions;
with Mathpack.Generic_Linears;
with Mathpack.Generic_Transformations;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Main is

   package Elementary_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   use Elementary_Functions;

   subtype Real is Float;
   package Real_Arrays is new Ada.Numerics.Generic_Real_Arrays (Real);

   subtype Vector is Real_Arrays.Real_Vector;
   subtype Matrix is Real_Arrays.Real_Matrix;

   --type Vector is array (Integer range <>) of Real;
   --type Matrix is array (Integer range <>, Integer range <>) of Real;



   package Vectors is new Mathpack.Generic_Linears (Real, Vector, Matrix, Sqrt);
   use Vectors;

   package Quaternions is new Mathpack.Generic_Quaternions (Real, Vector, Matrix, Sin, Cos);
   use Quaternions;

   package Tranformations is new Mathpack.Generic_Transformations (Real, Vector, Matrix, Tan, Pi);
   use Tranformations;


   procedure Put (V : Vector) is
   begin
      for E of V loop
         Put (E, 3, 2, 0);
      end loop;
   end;

   procedure Put (M : Matrix) is
   begin
      for I in M'Range(1) loop
         for J in M'Range(2) loop
            Put (M (I, J), 3, 2, 0);
         end loop;
         New_Line;
      end loop;
   end;

   Q1 : Quaternion := (2.0, 1.0, 1.0, 3.0);
   Q2 : Quaternion := (2.0, 1.0, 1.0, 0.0);

   Q3 : Quaternion;

   R4 : Rotation_4_4 := (others => (others => 0.0));

   C : Character;

begin

   Normalize (Q1);
   Normalize (Q2);

   Init_Rotation_Matrix (R4);

   Put (Q1);
   New_Line;
   Put (Q2);
   New_Line;

   Get_Immediate (C);

   loop
      Get_Immediate (C);

      Product (Q1, Q2, Q3);
      Q2 := Q3;

      Put_Line("Q3");
      Put (Q3);
      Put (" :");
      Put (abs Q3, 3, 2, 0);
      New_Line (2);

      Quaternion_To_Rotation_4_4 (Q3, R4);


      Put_Line("R4");
      Put (R4);
      New_Line;
      Put (Real_Arrays.Determinant (R4));
      New_Line (2);


      Put_Line("R4");
      Put (Real_Arrays."*"(Real_Arrays.Transpose(R4),R4));
      New_Line;
      Put (Real_Arrays.Determinant (R4));
      New_Line (2);



   end loop;

end;
