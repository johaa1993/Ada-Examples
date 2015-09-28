with Ada; use Ada;
with System; use System;
with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package GL is

   subtype GLbitfield is unsigned;
   subtype GLboolean is unsigned_char;
   subtype GLfloat is C_float;
   subtype GLint is int;
   subtype GLintptr is ptrdiff_t;
   subtype GLuint is unsigned;
   subtype GLenum is unsigned;
   subtype GLsizei is int;
   subtype GLsizeiptr is ptrdiff_t;
   subtype GLbyte is signed_char;
   subtype GLubyte is unsigned_char;
   subtype GLvoid is Address;
   subtype GLchar is char;
   subtype GLchar_array is char_array;

   GL_TRUE                 : constant := 1;
   GL_FALSE                : constant := 0;
   GL_FRAGMENT_SHADER      : constant := 16#8B30#;
   GL_VERTEX_SHADER        : constant := 16#8B31#;
   GL_GEOMETRY_SHADER      : constant := 16#8DD9#;
   GL_COMPILE_STATUS       : constant := 16#8B81#;
   GL_LINK_STATUS          : constant := 16#8B82#;
   GL_ARRAY_BUFFER         : constant := 16#8892#;
   GL_ELEMENT_ARRAY_BUFFER : constant := 16#8893#;
   GL_STATIC_DRAW          : constant := 16#88E4#;
   GL_FLOAT                : constant := 16#1406#;
   GL_TRIANGLES            : constant := 16#0004#;
   GL_ACTIVE_ATTRIBUTES    : constant := 16#8B89#;
   GL_MAJOR_VERSION        : constant := 16#821B#;
   GL_COLOR_BUFFER_BIT     : constant := 16#00004000#;
   GL_DEPTH_BUFFER_BIT     : constant := 16#00000100#;
   GL_DEPTH_TEST           : constant := 16#0B71#;
   GL_TEXTURE_MAG_FILTER   : constant := 16#2800#;
   GL_TEXTURE_MIN_FILTER   : constant := 16#2801#;
   GL_NEAREST              : constant := 16#2600#;
   GL_R3_G3_B2             : constant := 16#2a10#;
   GL_UNSIGNED_BYTE_3_3_2  : constant := 16#8032#;
   GL_RGB                  : constant := 16#1907#;
   GL_BGR                  : constant := 16#80e0#;
   GL_LUMINANCE            : constant := 16#1909#;
   GL_LUMINANCE8           : constant := 16#8040#;
   GL_ALPHA8               : constant := 16#803c#;
   GL_RED                  : constant := 16#1903#;
   GL_TEXTURE_WRAP_S       : constant := 16#2802#;
   GL_TEXTURE_WRAP_T       : constant := 16#2803#;
   GL_CLAMP                : constant := 16#2900#;
   GL_LINEAR               : constant := 16#2601#;
   GL_REPEAT               : constant := 16#2901#;
   GL_TEXTURE_BUFFER       : constant := 16#8C2A#;
   GL_TEXTURE_2D           : constant := 16#DE1#;
   GL_RGBA                 : constant := 16#1908#;
   GL_UNSIGNED_BYTE        : constant := 16#1401#;
   GL_MAX_UNIFORM_LOCATIONS: constant := 1024;

   type Access_glCreateProgram is access function return GLuint;
   type Access_glLinkProgram is access procedure (program : GLuint);
   type Access_glGetProgramiv is access procedure (program : GLuint; pname : GLenum; params : access GLint);
   type Access_glGetProgramInfoLog is access procedure (program : GLuint; maxLength : GLsizei; length : access GLsizei; infoLog : Address);
   type Access_glUseProgram is access procedure (program : GLuint) with Convention => C;
   type Access_glCreateShader is access function (shaderType : GLenum) return GLuint;
   type Access_glShaderSource is access procedure (shader : GLuint; count : GLsizei; string : access char_array; length : access GLint);
   type Access_glAttachShader is access procedure (program, shader : GLuint);
   type Access_glCompileShader is access procedure (shader : GLuint);
   type Access_glGetShaderInfoLog is access procedure (shader : GLuint; maxLength : GLsizei; length : access GLsizei; infoLog : Address);
   type Access_glGetShaderiv is access procedure (shader : GLuint; pname : GLenum; params : access GLint);
   type Access_glUniformMatrix4fv is access procedure (location : GLint; count : GLsizei; transpose : GLboolean; value : Address);
   type Access_glGetUniformLocation is access function (program : GLuint; name : char_array) return GLint with Convention => C;
   type Access_glGenVertexArrays is access procedure (n : GLsizei; arrays : access GLuint) with Convention => C;
   type Access_glBindVertexArray is access procedure (arr : GLuint) with Convention => C;
   type Access_glGenBuffers is access procedure (n : GLsizei; buffers : access GLuint) with Convention => C;
   type Access_glBindBuffer is access procedure (target : GLenum; buf : GLuint) with Convention => C;
   type Access_glBufferData is access procedure (target : GLenum; size : GLsizeiptr; data : Address; usage : GLenum) with Convention => C;
   type Access_glVertexAttribPointer is access procedure (index : GLuint; size : GLint; t : GLenum; normalized : GLboolean; stride : GLsizei; pointer : System.Address) with Convention => C;
   type Access_glEnableVertexAttribArray is access procedure (index : GLuint) with Convention => C;
   type Access_glIsShader is access function (shader : GLuint) return GLboolean with Convention => C;
   type Access_glIsProgram is access function (program : GLuint) return GLboolean with Convention => C;
   type Access_glIsBuffer is access function (buffer : GLuint) return GLboolean with Convention => C;
   type Access_glIsVertexArray is access function (arr : GLuint) return GLboolean with Convention => C;
   type Access_glGetAttribLocation is access function (program : GLuint; name : char_array) return GLint with Convention => C;
   type Access_glVertexArrayAttribFormat is access procedure (vaobj : GLuint; attribindex : GLuint; size : GLint; t : GLenum; normalized : GLboolean; relativeoffset : GLuint) with Convention => C;
   type Access_glBufferSubData is access procedure (target : GLenum; offset : GLintptr; size : GLsizeiptr; data : System.Address) with Convention => C;


   glCreateProgram           : Access_glCreateProgram;
   glCreateShader            : Access_glCreateShader;
   glAttachShader            : Access_glAttachShader;
   glLinkProgram             : Access_glLinkProgram;
   glCompileShader           : Access_glCompileShader;
   glShaderSource            : Access_glShaderSource;
   glGetShaderInfoLog        : Access_glGetShaderInfoLog;
   glGetShaderiv             : Access_glGetShaderiv;
   glGetProgramiv            : Access_glGetProgramiv;
   glGetProgramInfoLog       : Access_glGetProgramInfoLog;
   glUniformMatrix4fv        : Access_glUniformMatrix4fv;
   glGetUniformLocation      : Access_glGetUniformLocation;
   glGenVertexArrays         : Access_glGenVertexArrays;
   glGenBuffers              : Access_glGenBuffers;
   glBindVertexArray         : Access_glBindVertexArray;
   glBindBuffer              : Access_glBindBuffer;
   glBufferData              : Access_glBufferData;
   glBufferSubData           : Access_glBufferSubData;
   glVertexAttribPointer     : Access_glVertexAttribPointer;
   glEnableVertexAttribArray : Access_glEnableVertexAttribArray;
   glUseProgram              : Access_glUseProgram;
   glIsShader                : Access_glIsShader;
   glIsProgram               : Access_glIsProgram;
   glIsBuffer                : Access_glIsBuffer;
   glIsVertexArray           : Access_glIsVertexArray;
   glGetAttribLocation       : Access_glGetAttribLocation;
   glVertexArrayAttribFormat : Access_glVertexArrayAttribFormat;


   procedure glDrawArrays (mode : GLenum; first : GLint; count : GLsizei) with
     Import,
     Convention => StdCall,
     External_Name => "glDrawArrays";

   function glGetError return GLenum with
     Import,
     Convention => StdCall,
     External_Name => "glGetError";

   procedure glGetIntegerv (pname : GLenum; data : access GLint) with
     Import,
     Convention => StdCall,
     External_Name => "glGetIntegerv";

   procedure glClear (Bits : GLbitfield) with
     Import,
     Convention => StdCall,
     External_Name => "glClear";

   procedure glEnable (cap : GLenum) with
     Import,
     Convention => StdCall,
     External_Name => "glEnable";

   procedure glDisable (cap : GLenum) with
     Import,
     Convention => StdCall,
     External_Name => "glDisable";

   procedure glGenTextures (n : GLsizei; textures : access GLuint) with
     Import,
     Convention => StdCall,
     External_Name => "glGenTextures";

   procedure glBindTexture (target : GLenum; texture : GLuint) with
     Import,
     Convention => StdCall,
     External_Name => "glBindTexture";

   procedure glTexImage2D (Target : GLenum; Level : GLint; internalformat : GLint; Width, Height : GLsizei; Border : GLint; Format : GLenum; Data_Type : GLenum; Data : Address) with
     Import,
     Convention => StdCall,
     External_Name => "glTexImage2D";

   procedure glTexParameteri (target : GLenum; pname : GLenum; param : GLint) with
     Import,
     Convention => StdCall,
     External_Name => "glTexParameteri";


end;
