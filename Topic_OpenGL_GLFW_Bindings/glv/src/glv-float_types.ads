with GL; use GL;

package GLV.Float_Types is

   type Matrix is array (Integer range <>, Integer range <>) of GLfloat;

   subtype Matrix_1 is Matrix (1 .. 1, 1 .. 1);
   subtype Matrix_2 is Matrix (1 .. 2, 1 .. 2);
   subtype Matrix_3 is Matrix (1 .. 3, 1 .. 3);
   subtype Matrix_4 is Matrix (1 .. 4, 1 .. 4);

   type Matrix_1_Array is array (Integer range <>) of Matrix_1;
   type Matrix_2_Array is array (Integer range <>) of Matrix_2;
   type Matrix_3_Array is array (Integer range <>) of Matrix_3;
   type Matrix_4_Array is array (Integer range <>) of Matrix_4;


   type Vector is array (Integer range <>) of GLfloat;

   subtype Vector_1 is Vector (1 .. 1);
   subtype Vector_2 is Vector (1 .. 2);
   subtype Vector_3 is Vector (1 .. 3);
   subtype Vector_4 is Vector (1 .. 4);

   type Vector_1_Array is array (Integer range <>) of Vector_1;
   type Vector_2_Array is array (Integer range <>) of Vector_2;
   type Vector_3_Array is array (Integer range <>) of Vector_3;
   type Vector_4_Array is array (Integer range <>) of Vector_4;




end;
