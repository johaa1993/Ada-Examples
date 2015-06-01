
--Altough package is named CSV comma seperated value,
--the seperating character is still optional.

package CSV is

   type Row is record
      --Start index
      A : Positive;
      --Separator index
      P : Natural;
   end record;

   function Create ( S : String ) return Row;

   function Next (R : in out Row; S : String; Sep : Character) return Boolean;

   function Get ( R : in Row; S : String ) return String;

end;
