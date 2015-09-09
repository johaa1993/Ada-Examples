with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with GNAT.Altivec.Vector_Types; use GNAT.Altivec.Vector_Types;
with GNAT.Altivec.Vector_Operations; use GNAT.Altivec.Vector_Operations;
with GNAT.Altivec.Conversions; use GNAT.Altivec.Conversions;
with Ada.Unchecked_Conversion;

procedure Main is

   type Float_Array is array (Integer range 0 .. 3) of Float;
   for Float_Array'Alignment use 16;

   function Convert is new Ada.Unchecked_Conversion (Float_Array, vector_float);

   type Mode is (Array_Mode, Vector_Mode);
   type Float_Record (M : Mode) is record
      case M is
      when Array_Mode =>
         A : Float_Array;
      when Vector_Mode =>
         V : Vector_Float;
      end case;
   end record;

   pragma Unchecked_Union (Float_Record);

   A : vector_float := Convert ((1.0, 1.0, 1.0, 1.0));
   B : vector_float := Convert ((1.0, 2.0, 1.0, 1.0));
   C : Float_Record := (M => Vector_Mode, V => vec_add (A, B));

begin

   for E of C.A loop
      Put (E, 3, 3, 0);
   end loop;

end;
