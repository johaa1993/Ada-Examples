with GLFW;
with GLFW.API;
with Interfaces.C;

package body GLFW is

   -- http://www.adahome.com/FAQ/programming.html
   -- Make operations directly visible
   use type System.Address;
   use type Interfaces.C.int;

   procedure Initialize is
      Result : Interfaces.C.int := API.glfwInit;
   begin
      if Result /= 1 then
	 raise RunTimeError;
      end if;
   end;

   function CreateWindow
   (
    Width, Height : in Positive;
    Title         : in String
   )
   return Window is
      CWidth : constant Interfaces.C.int := Interfaces.C.int(Width);
      CHeight : constant Interfaces.C.int := Interfaces.C.int(Height);
      CTitle : constant Interfaces.C.char_array := Interfaces.C.To_C(Title);
      CWindow : constant System.Address := API.glfwCreateWindow(CWidth, CHeight, CTitle);
   begin
      if CWindow = System.Null_Address then
	 raise RunTimeError;
      end if;
      return Window(CWindow);
   end CreateWindow;

   procedure PollEvents is
   begin
      API.glfwPollEvents;
      null;
   end PollEvents;

   function WindowShouldClose(w : in Window) return Boolean is
      CAddress : constant System.Address := System.Address(w);
      CFlag : constant Interfaces.C.int := API.glfwWindowShouldClose(CAddress);
   begin
      return CFlag = 1;
   end WindowShouldClose;

end Glfw;
