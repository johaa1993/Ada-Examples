with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with System; use System;

package GLFW is


   subtype GLFWwindow is Address;
   subtype GLFWmonitor is Address;
   subtype GLFWglproc is Address;

   Null_GLFWwindow : GLFWwindow := GLFWwindow (Null_Address);
   Null_GLFWmonitor : GLFWmonitor := GLFWmonitor (Null_Address);
   Null_GLFWglproc : GLFWglproc := GLFWglproc (Null_Address);

   function glfwGetProcAddress (Name : char_array) return GLFWglproc with
   Import,
   Convention => C,
   External_Name => "glfwGetProcAddress";


   -- This function initializes the GLFW library.
   -- Before most GLFW functions can be used, GLFW must be initialized, and before an application terminates GLFW should be terminated in order to free any resources allocated during or after initialization.
   -- If this function fails, it calls glfwTerminate before returning.
   -- If it succeeds, you should call glfwTerminate before the application exits.
   -- Additional calls to this function after successful initialization but before termination will return GL_TRUE immediately.
   function glfwInit return int with
   Import,
   Convention => C,
   External_Name => "glfwInit";


   -- This function creates a window and its associated OpenGL or OpenGL ES context.
   -- Most of the options controlling how the window and its context should be created are specified with window hints.
   --
   -- Successful creation does not change which context is current.
   -- Before you can use the newly created context, you need to make it current.
   -- For information about the share parameter, see Context object sharing.
   function glfwCreateWindow (Width : int; Height : int; Title : char_array; Primary : GLFWmonitor := Null_GLFWmonitor; Share : GLFWwindow := Null_GLFWwindow) return GLFWwindow with
   Import,
   Convention => C,
   External_Name => "glfwCreateWindow";


   -- http://www.glfw.org/docs/latest/group__window.html#ga24e02fbfefbb81fc45320989f8140ab5
   function glfwWindowShouldClose (W : GLFWwindow) return int with
   Import,
   Convention => C,
   External_Name => "glfwWindowShouldClose";


   -- http://www.glfw.org/docs/latest/group__window.html#ga37bd57223967b4211d60ca1a0bf3c832
   procedure glfwPollEvents with
   Import,
   Convention => C,
   External_Name => "glfwPollEvents";


   procedure glfwMakeContextCurrent (W : GLFWwindow) with
   Import,
   Convention => C,
   External_Name => "glfwMakeContextCurrent";


   type GLFWdropfun is access procedure (W : GLFWwindow; Count : int; Paths : chars_ptr_array ) with
   Convention => C;


   procedure glfwSetDropCallback (W : GLFWwindow; P : GLFWdropfun) with
   Import,
   Convention => C,
   External_Name => "glfwSetDropCallback";


   procedure glfwWindowHint (Target : int; Hint : int) with
   Import,
   Convention => C,
   External_Name => "glfwWindowHint";


   procedure glfwSwapBuffers (W : GLFWwindow) with
   Import,
   Convention => C,
   External_Name => "glfwSwapBuffers";


   procedure glfwGetCursorPos (W : GLFWwindow; X : out double; Y : out double) with
   Import,
   Convention => C,
   External_Name => "glfwGetCursorPos";


   function glfwGetKey (W : GLFWwindow; key : int) return int with
   Import,
   Convention => C,
   External_Name => "glfwGetKey";


   procedure glfwDestroyWindow (W : GLFWwindow) with
     Import,
     Convention => C,
     External_Name => "glfwDestroyWindow";


   GLFW_VISIBLE : constant := 16#00020004#;
   GLFW_FALSE : constant := 0;
   GLFW_TRUE : constant := 1;
   GLFW_RELEASE : constant := 0;
   GLFW_PRESS   : constant := 1;
   GLFW_KEY_SPACE : constant := 32;
   GLFW_KEY_A : constant := 65;
   GLFW_KEY_B : constant := 66;
   GLFW_KEY_D : constant := 68;
   GLFW_KEY_S : constant := 83;
   GLFW_KEY_W : constant := 87;
   GLFW_KEY_RIGHT : constant := 262;
   GLFW_KEY_LEFT : constant := 263;
   GLFW_KEY_DOWN : constant := 264;
   GLFW_KEY_UP : constant := 265;
   GLFW_KEY_LEFT_CONTROL : constant := 341;


end GLFW;






