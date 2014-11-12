with parent.child;
with parent.privatechild;

package body parent is
	procedure test is
	begin
		parent.child.test;
		parent.privatechild.test;
	end test;
end parent;
