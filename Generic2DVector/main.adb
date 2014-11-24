with Ada.Text_IO;
procedure Main is

   generic
      type T is private;
      
      --http://stackoverflow.com/questions/13417337/defining-a-generic-scalar-type-package-in-ada
      with function "+" (A, B : T) return T is <>;
   package Vector2 is
      type Item is record
	 X : T;
	 Y : T;
      end record;
      function "+" (A, B: Item) return Item;
   end Vector2;

   package body Vector2 is
      function "+" (A, B: Item) return Item is
         R : Item;
      begin
         R.X := A.X + B.X;
         R.Y := A.Y + B.Y;
         return R;
      end;
   end Vector2;
   
   package Vec2i is new Vector2(Integer);
   package Vec2f is new Vector2(Float);
   
   --http://www.adahome.com/FAQ/programming.html#visible_ops
   use type Vec2i.Item;
   use type Vec2f.Item;
   
   Vec2i0 : Vec2i.Item := (4, 2);
   Vec2f0 : Vec2f.Item := (1.3, 3.7);
   
begin

   Vec2i0 := Vec2i0 + Vec2i0;
   Vec2f0 := Vec2f0 + Vec2f0;
   
   Ada.Text_IO.Put_Line(Vec2i0.X'Img & Vec2i0.Y'Img);
   Ada.Text_IO.Put_Line(Vec2f0.X'Img & Vec2f0.Y'Img);
   
end Main;
