

package body GLV.Draws is

   procedure Draw_Arrays (Method : Mode; First : Index; Number : Count) is
   begin
      glDrawArrays (Method'Enum_Rep, First, Number);
   end;


end;
