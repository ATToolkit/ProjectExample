#!/usr/sbin/dtrace -s
#pragma D option quiet

unsigned long long indention;
int indentation_amount;
typedef long long ptr_t;

BEGIN {
  indentation_amount = 1;
}

objc$target:$1:-initWithName?productTypeIdentifier?templateDictionary?baseDirectoryPath?:entry
/
	arg5 != 0
/
{
       this->str = *(ptr_t*)copyin(arg5+2*sizeof(ptr_t), sizeof(ptr_t));

       printf("string addr = %p\n", this->str);
       printf("string val  = %s\n", copyinstr(this->str));
}

