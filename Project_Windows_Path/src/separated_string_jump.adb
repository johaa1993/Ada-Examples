procedure Separated_String_Jump (Str : String; Sep : Character; P : in out Positive) is
begin
   while P <= Str'Last and then Str(P) = Sep loop
      P := P + 1;
   end loop;
   while P <= Str'Last and then Str(P) /= Sep loop
      P := P + 1;
   end loop;
   while P <= Str'Last and then Str(P) = Sep loop
      P := P + 1;
   end loop;
end;
