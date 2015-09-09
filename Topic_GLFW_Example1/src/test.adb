with GLFW;
with Ada.Text_IO;

procedure Test is
begin
   
   GLFW.Initialize;
   
   declare
      Window : constant GLFW.Window := GLFW.CreateWindow(640, 480, "Hello");
   begin
      loop
	 GLFW.PollEvents;
	 exit when GLFW.WindowShouldClose(Window);
      end loop;
   end;
   
end Test;
