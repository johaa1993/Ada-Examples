with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
with Ada.Float_Text_IO;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C;
with System; use System;
with System.Address_Image;

with GL; use GL;
with GL.Init;
with GLFW; use GLFW;
with Interfaces; use Interfaces;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;



procedure Main is

   function Load (Name : String) return Address is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Interfaces.C;
      Procedure_Name : char_array := Interfaces.C.To_C(Name);
      Procedure_Address : Address := glfwGetProcAddress (Procedure_Name);
   begin
      Put (Head(Name, 30));
      Put (Address_Image(Procedure_Address));
      New_Line;
      return Procedure_Address;
   end;




   package Bitmaps is

      type Compression is (None_Compression, Run_Length_Encoding_8_Compression);
      for Compression'Size use 32;
      for Compression use (None_Compression => 0, Run_Length_Encoding_8_Compression => 1);

      type Signature is (BM_Signature);
      for Signature'Size use 16;
      for Signature use (BM_Signature => 16#4D42#);

      type File_Header is record
         Sign       : Signature;
         Size       : Unsigned_32; -- File size in bytes
         Reserved_1 : Unsigned_16;
         Reserved_2 : Unsigned_16;
         Offset     : Unsigned_32; -- Offset bytes to pixel data.
      end record;

      type Bitmap_Information_Header is record
         Header_Size           : Unsigned_32;
         Width                 : Unsigned_32; -- Image width in pixels
         Height                : Unsigned_32; -- Image hieght in pixels
         Plane_Count           : Unsigned_16;
         Pixel_Size            : Unsigned_16; -- Bits per pixel
         Compress              : Compression;
         Image_Size            : Unsigned_32; -- Size of the image data in bytes
         Horizontal_Resolution : Unsigned_32; -- Pixels per meter in horizontal axis
         Vertical_Resolution   : Unsigned_32; -- Pixels per meter in vertical axis
         Color_Count           : Unsigned_32; -- Number of colors used
         Important_Color_Count : Unsigned_32; -- Number of important colors
      end record;

      type Bitmap_Header is record
         File_Head        : File_Header;
         Information_Head : Bitmap_Information_Header;
      end record;


      type Pixel_RGB is (Red, Green, Blue);
      type Pixel_RGBA is (Red, Green, Blue, Alpha);
      subtype Pixel_8 is Unsigned_8;
      subtype Pixel_8_Component is Pixel_8;
      subtype Pixel_8_Grayscale is Pixel_8; -- 0..255 = black..white
      type Pixel_24_RGB is array (Pixel_RGB) of Pixel_8_Component;
      type Pixel_32_RGBA is array (Pixel_RGBA) of Pixel_8_Component;

   end;

   use Bitmaps;





   procedure Put_Image (Bitmap : Bitmap_Header) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      package Unsigned_32_Text_IO is new Modular_IO (Unsigned_32);
      package Unsigned_16_Text_IO is new Modular_IO (Unsigned_16);
      use Unsigned_32_Text_IO;
      use Unsigned_16_Text_IO;
      Column_1_Width : constant := 25;
      Column_2_Width : constant := 20;
   begin
      Put (Head("Signature", Column_1_Width));
      Put (Tail(Bitmap.File_Head.Sign'Img, Column_2_Width));
      New_Line;
      Put (Head("Size ", Column_1_Width));
      Put (Bitmap.File_Head.Size, Column_2_Width);
      New_Line;
      Put (Head("Reserved_1", Column_1_Width));
      Put (Bitmap.File_Head.Reserved_1, Column_2_Width);
      New_Line;
      Put (Head("Reserved_1", Column_1_Width));
      Put (Bitmap.File_Head.Reserved_1, Column_2_Width);
      New_Line;
      Put (Head("Offset", Column_1_Width));
      Put (Bitmap.File_Head.Offset, Column_2_Width);
      New_Line;
      Put (Head("Header_Size", Column_1_Width));
      Put (Bitmap.Information_Head.Header_Size, Column_2_Width);
      New_Line;
      Put (Head("Width", Column_1_Width));
      Put (Bitmap.Information_Head.Width, Column_2_Width);
      New_Line;
      Put (Head("Height", Column_1_Width));
      Put (Bitmap.Information_Head.Height, Column_2_Width);
      New_Line;
      Put (Head("Plane_Count", Column_1_Width));
      Put (Bitmap.Information_Head.Plane_Count, Column_2_Width);
      New_Line;
      Put (Head("Pixel_Size", Column_1_Width));
      Put (Bitmap.Information_Head.Pixel_Size, Column_2_Width);
      New_Line;
      Put (Head("Compression", Column_1_Width));
      Put (Tail(Bitmap.Information_Head.Compress'Img, Column_2_Width));
      New_Line;
      Put (Head("Image_Size", Column_1_Width));
      Put (Bitmap.Information_Head.Image_Size, Column_2_Width);
      New_Line;
      Put (Head("Horizontal_Resolution", Column_1_Width));
      Put (Bitmap.Information_Head.Horizontal_Resolution, Column_2_Width);
      New_Line;
      Put (Head("Vertical_Resolution", Column_1_Width));
      Put (Bitmap.Information_Head.Vertical_Resolution, Column_2_Width);
      New_Line;
      Put (Head("Color_Count", Column_1_Width));
      Put (Bitmap.Information_Head.Color_Count, Column_2_Width);
      New_Line;
      Put (Head("Important_Color_Count", Column_1_Width));
      Put (Bitmap.Information_Head.Important_Color_Count, Column_2_Width);
      New_Line;
   end;


   procedure Read_Image (Name : String) is
      use Ada.Streams.Stream_IO;
      File : File_Type;
      Streamer : Stream_Access;
      Bitmap : Bitmap_Header;
   begin
      Open (File, In_File, Name);
      Streamer := Stream (File);
      Bitmap_Header'Read (Streamer, Bitmap);
      Set_Index (File, Positive_Count (Bitmap.File_Head.Offset));
      declare
         use Ada.Text_IO;
      begin
         Put_Line ("Bitmap");
         Put_Image (Bitmap);
         New_Line (2);
      end;
   end;


   procedure Start_Window (Window : out GLFWwindow) is
      use Interfaces.C;
      use Ada.Text_IO;
      Title : char_array := "Hello";
      glfwInit_Result : int;
   begin
      glfwInit_Result := glfwInit;
      Window := glfwCreateWindow (200, 200, Title);
      glfwMakeContextCurrent (Window);
      Put_Line ("GL.Init");
      GL.Init (Load'Access);
   end;


   procedure Main_Loop (Window : GLFWwindow) is
      use type Interfaces.C.int;
   begin
      loop
         glfwPollEvents;
         exit when glfwWindowShouldClose (Window) = 1;
      end loop;
   end;


   Window : GLFWwindow;

begin

   Start_Window (Window);

   Read_Image ("lena512.bmp");


--
--     declare
--        use Ada.Text_IO;
--        type Pixel_Matrix is array (1 .. Integer(Bitmap.Information_Head.Width), 1 .. Integer(Bitmap.Information_Head.Height)) of Pixel_8_Grayscale;
--        Image : Pixel_Matrix;
--        package Pixel_8_Grayscale_Text_IO is new Modular_IO (Pixel_8_Grayscale);
--        use Pixel_8_Grayscale_Text_IO;
--     begin
--        Pixel_Matrix'Read(Streamer, Image);
--        Ada.Streams.Stream_IO.Close(File);
--        for I in Image'First(1) .. Image'First(1) + 400 loop
--           for J in Image'First(2) .. Image'First(2) + 400 loop
--              Put (Image(I, J), 3);
--           end loop;
--           New_Line;
--        end loop;
--        delay 10.0;
--     end;
--
--







   Main_Loop (Window);



end;
