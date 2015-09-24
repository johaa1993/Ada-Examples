package body GLV.Windows.Keys is

   function Get (Win : Window; Button : Key) return Boolean is
   begin
      return glfwGetKey (Win.API, Button'Enum_Rep) = GLFW_PRESS;
   end;


end;
