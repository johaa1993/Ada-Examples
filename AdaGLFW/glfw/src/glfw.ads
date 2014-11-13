with System;


package GLFW is

   type Window is private;

   procedure Initialize;
   procedure PollEvents;
   function CreateWindow(Width, Height : in Positive; Title : in String) return Window;
   function WindowShouldClose(w : in Window) return Boolean;

   RunTimeError : exception;

   -- procedure test;

private
   type Window is new System.Address;



end Glfw;
