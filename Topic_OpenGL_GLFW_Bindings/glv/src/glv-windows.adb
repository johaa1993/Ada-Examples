with Interfaces.C;

package body GLV.Windows is

   use Interfaces.C;

   function Create (Width, Height : Natural; Title : String) return Window is
      W : GLFWWindow := glfwCreateWindow (int(Width), int(Height), To_C (Title));
   begin
      return Window'(W => W);
   end;

   procedure Make_Context_Current (W : Window) is
   begin
      glfwMakeContextCurrent (W.W);
   end;

   function Closing (W : Window; Flag : Integer := 1) return Boolean is
   begin
      return glfwWindowShouldClose (W.W) = int(Flag);
   end;

   procedure Pull_Events is
   begin
      glfwPollEvents;
   end;

   procedure Swap_Buffers (W : Window) is
   begin
      glfwSwapBuffers (W.W);
   end;

   procedure Destroy (W : Window) is
   begin
      glfwDestroyWindow (W.W);
   end;

end;
