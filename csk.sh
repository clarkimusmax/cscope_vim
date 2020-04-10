#!/bin/bash

# Mostly stolen from:
# http://cscope.sourceforge.net/large_projects.html

if [ $# -ne 1 ]; then
	echo "Usage: `basename $0` [path-to-kernel-source-dir]"
	exit
fi

if [ $1 == "." ]; then
	LNX=`pwd`
elif [ $1 == ".." ]; then
	cd ..
	LNX=`pwd`
else
	LNX=$1
fi

cd / 	

find  $LNX                                                                    \
	-path "$LNX/arch/*" ! -path "$LNX/arch/i386*" -prune -o               \
	-path "$LNX/include/asm-*" ! -path "$LNX/include/asm-i386*" -prune -o \
	-path "$LNX/tmp*" -prune -o                                           \
	-path "$LNX/Documentation*" -prune -o                                 \
	-path "$LNX/scripts*" -prune -o                                       \
	-path "$LNX/drivers*" -prune -o                                       \
	-type f -name "*\.[chxsS]" -print > $LNX/cscope.files

cd $LNX

cscope -b -k

rm $LNX/cscope.files
