with Ada.Text_IO;

procedure Main is

   use Ada.Text_IO;
   
   type String_Access is access all String;
   
   function Str_10 return String is
      S : String (1 .. 10) := (others => '0');
   begin
      return S;
   end;
   
   Str_1 : aliased String := "0123456789";
   Str_2 : aliased String := Str_10;
   Str_3 : aliased String (1 .. 10) := (others => '0');

   Str_Acc_1 : String_Access := Str_1'Access;
   Str_Acc_2 : String_Access := Str_2'Access;
   --Str_Acc_3 : String_Access := Str_3'Access;
   --Str_Acc_4 : String_Access := Str_3'Unchecked_Access;
   Str_Acc_5 : String_Access := Str_3'Unrestricted_Access;
   
begin
   Put_Line (Str_Acc_5'Last'Img);
   Put_Line (Str_Acc_5'First'Img);
   
   Put_Line (Str_Acc_5.all);
   Put_Line (Str_Acc_5.all);
   Put_Line (Str_Acc_5.all);
   Put_Line (Str_Acc_5.all);
   
   null;
end;
