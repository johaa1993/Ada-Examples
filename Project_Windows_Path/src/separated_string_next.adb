function Separated_String_Next (Str : String; Sep : Character; P : in out Positive) return String is
   A : Positive := P;
   B : Positive;
begin
   while A <= Str'Last and then Str(A) = Sep loop
      A := A + 1;
   end loop;
   P := A;
   while P <= Str'Last and then Str(P) /= Sep loop
      P := P + 1;
   end loop;
   B := P - 1;
   while P <= Str'Last and then Str(P) = Sep loop
      P := P + 1;
   end loop;
   return Str(A .. B);
end;
