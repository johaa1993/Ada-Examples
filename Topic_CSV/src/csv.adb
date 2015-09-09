package body CSV is


   function Create ( S : String ) return Row is
   begin
      --Initialize the separator index to undefined.
      return Row'(S'First, S'First - 1);
   end;


   function Next(R : in out Row; S : String; Sep : Character) return Boolean is
   begin
      --Point start index to after the previus separator index.
      R.P := R.P + 1;

      --Point separator index to after the previus separator index.
      R.A := R.P;

      --Find the next separator index.
      while R.P <= S'Last and then S(R.P) /= Sep loop
         R.P := R.P + 1;
      end loop;

      --If start index exceeds the last string index then return false.
      return R.A <= S'Last;
   end;


   function Get ( R : in Row; S : String ) return String is
   begin
      --Subtract one from separator index to exclude separator character.
      return S (R.A .. R.P - 1);
   end;


end;
