#!/usr/sbin/dtrace -s
#pragma D option quiet

unsigned long long indention;
int indentation_amount;
typedef long long ptr_t;

BEGIN {
  indentation_amount = 1;
}

objc$target:PBXProject:-init:entry
{
	    tracing++;
}

objc$target:PBXProject:-init:return
{
	    tracing--;
}

objc$target:PBXGroup:+groupWithName?path?:entry
{
	printf("name == %s", arg2 == 0 ? "nil" : "non-nil");
	printf("path == %s", arg3 == 0 ? "nil" : "non-nil");
}

objc$target:PBXGroup:+groupWithName?path?:entry
/
	arg3 != 0
/
{
	this->str = *(ptr_t*)copyin(arg3+2*sizeof(ptr_t), sizeof(ptr_t));

	printf("string addr = %p\n", this->str);
	printf("string val  = %s\n", copyinstr(this->str));
}

objc$target:PBXGroup:+groupWithName?path?:entry
/
	arg2 != 0
/
{
	this->str = *(ptr_t*)copyin(arg2+2*sizeof(ptr_t), sizeof(ptr_t));

	printf("string addr = %p\n", this->str);
	printf("string val  = %s\n", copyinstr(this->str));
}

objc$target:$1::entry
/
tracing > 0 &&
&probefunc[1] != "retain" &&
&probefunc[1] != "release" &&
&probefunc[1] != "_tryRetain" &&
&probefunc[1] != "willChange" &&
&probefunc[1] != "_isDeallocating" &&
&probefunc[1] != "willChangeWithArchivePriority:"
/
{
    method = (string)&probefunc[1];
    type = probefunc[0];
    class = probemod;
    printf("%*s%s %c[%s %s]\n", indention * indentation_amount, "", "->", type, class, method);
    indention++;
}
objc$target:$1::return
/
tracing > 0 &&
&probefunc[1] != "retain" &&
&probefunc[1] != "release" &&
&probefunc[1] != "_tryRetain" &&
&probefunc[1] != "willChange" &&
&probefunc[1] != "_isDeallocating" &&
&probefunc[1] != "willChangeWithArchivePriority:"
/
{
    indention--;
    method = (string)&probefunc[1];
    type = probefunc[0];
    class = probemod;
    printf("%*s%s %c[%s %s]\n", indention * indentation_amount, "", "<-", type, class, method);
}
