with GLFW;

package GLV.Windows is

   type Window is private;

   procedure Make_Context_Current (W : Window);
   function Create (Width, Height : Natural; Title : String) return Window;
   function Closing (W : Window; Flag : Integer := 1) return Boolean;
   procedure Pull_Events;
   procedure Swap_Buffers (W : Window);
   procedure Destroy (W : Window);

private

   use GLFW;

   type Window is record
      W : GLFWWindow;
   end record;

end;
