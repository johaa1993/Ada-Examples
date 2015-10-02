with GL; use GL;

package GLV.Colors is

   type RGBA is (Red, Green, Blue, Alpha);

   type RGBA_ubyte is array (RGBA) of GLubyte;
   type RGBA_float is array (RGBA) of GLfloat;

end;
