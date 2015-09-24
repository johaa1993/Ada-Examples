with GLFW;
with Interfaces.C;

package GLV.Windows.Keys is

   use GLFW;

   type Key is
     (
      Space,
      A,
      B,
      D,
      S,
      W,
      Right,
      Left,
      Down,
      Up,
      Left_Control
     );

   function Get (Win : Window; Button : Key) return Boolean;

private

   use Interfaces.C;

   for Key use
     (
      GLFW_KEY_SPACE,
      GLFW_KEY_A,
      GLFW_KEY_B,
      GLFW_KEY_D,
      GLFW_KEY_S,
      GLFW_KEY_W,
      GLFW_KEY_RIGHT,
      GLFW_KEY_LEFT,
      GLFW_KEY_DOWN,
      GLFW_KEY_UP,
      GLFW_KEY_LEFT_CONTROL
     );
   for Key'Size use int'Size;

end;
