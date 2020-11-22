#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo "Usage: AT&T syntax for asm statement"
	echo "       get_opcode.sh \"pop %r15\""
	echo "       get_opcode.sh \"pop %r14;pop %rdi\""
	exit
fi

#asm=$(echo "$1" | awk '{gsub(/;/,"\\n\\t")}1')

code="__asm__(\"$1\");"

random_s=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w32 | head -n1)

cprog="$random_s.c" 
exe=$random_s

echo $code > $cprog

gcc $cprog -c -o $exe 2>/dev/null
if [ $? -ne 0 ]; then
	echo "Wrong asm statement entered!"
fi
objdump -d ./$exe 2>/dev/null
rm ./$exe 2>/dev/null
rm ./$cprog 2>/dev/null