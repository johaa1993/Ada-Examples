with GLFW;

package GLV.Windows is

   type Window is private;

   procedure Current (W : Window);
   function Create (Width, Height : Natural) return Window;
   function Closing (W : Window) return Boolean;
   procedure Pull_Events;
   procedure Swap (W : Window);
   procedure Destroy (W : Window);

private

   use GLFW;

   type Window is record
      API : GLFWWindow;
   end record;

end;
