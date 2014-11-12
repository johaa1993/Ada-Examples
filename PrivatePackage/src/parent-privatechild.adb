with Ada.Text_IO;

package body parent.privatechild is
	procedure test is
	begin
		Ada.Text_IO.Put_Line("testing parent.privatechild");
	end test;
end parent.privatechild;