with Interfaces.C;

private package GLFW.API is

   -- http://www.glfw.org/docs/latest/group__init.html#ga317aac130a235ab08c6db0834907d85e

   function glfwInit return Interfaces.C.int;
   pragma Import
   (
    Convention => C,
    Entity => glfwInit,
    External_Name => "glfwInit"
   );

   -- http://www.glfw.org/docs/latest/group__window.html#ga5c336fddf2cbb5b92f65f10fb6043344

   function glfwCreateWindow
   (
    Width, Height : Interfaces.C.int;
    Title         : Interfaces.C.char_array;
    Monitor       : System.Address := System.Null_Address;
    Share         : System.Address := System.Null_Address
   )
   return System.Address;
   pragma Import
   (
    Convention => C,
    Entity => glfwCreateWindow,
    External_Name => "glfwCreateWindow"
   );



   -- http://www.glfw.org/docs/latest/group__window.html#ga24e02fbfefbb81fc45320989f8140ab5

   function glfwWindowShouldClose
   (
    arg1 : System.Address
   )
   return Interfaces.C.int;
   pragma Import
   (
    Convention => C,
    Entity => glfwWindowShouldClose,
    External_Name => "glfwWindowShouldClose"
   );


   -- http://www.glfw.org/docs/latest/group__window.html#ga37bd57223967b4211d60ca1a0bf3c832

   procedure glfwPollEvents;
   pragma Import
   (
    Convention => C,
    Entity => glfwPollEvents,
    External_Name => "glfwPollEvents"
   );



end GLFW.API;
