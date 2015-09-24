with Interfaces; use Interfaces;

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

   type Information_Header is record
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
      File        : File_Header;
      Information : Information_Header;
   end record;

   type Pixel_RGB is (Red, Green, Blue);
   type Pixel_RGBA is (Red, Green, Blue, Alpha);
   subtype Component_8 is Unsigned_8;

   -- 0 .. 255 = black .. white
   subtype Pixel_8_Grayscale is Component_8;

   type Pixel_24_RGB is array (Pixel_RGB) of Component_8;
   type Pixel_32_RGBA is array (Pixel_RGBA) of Component_8;

private

   procedure Dummy;

end;
