with Interfaces.C;

package body GLV.Windows is

   use Interfaces.C;

   function Create (Width, Height : Natural) return Window is
      API : GLFWWindow := glfwCreateWindow (int(Width), int(Height), To_C ("No Title"));
   begin
      return Window'(API => API);
   end;

   procedure Current (W : Window) is
   begin
      glfwMakeContextCurrent (W.API);
   end;

   function Closing (W : Window) return Boolean is
   begin
      return glfwWindowShouldClose (W.API) = 1;
   end;

   procedure Pull_Events is
   begin
      glfwPollEvents;
   end;

   procedure Swap (W : Window) is
   begin
      glfwSwapBuffers (W.API);
   end;

   procedure Destroy (W : Window) is
   begin
      glfwDestroyWindow (W.API);
   end;

end;
