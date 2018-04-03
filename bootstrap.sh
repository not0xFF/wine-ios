#!/bin/bash

echo "Starting build..."
echo "Checking for tools..."
#check that everything we need is installed
command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
#if git isn't installed something got fucked up
command -v autoconf >/dev/null 2>&1 || { echo >&2 "I require autoconf but it's not installed.  Aborting."; exit 1; }
command -v autoreconf >/dev/null 2>&1 || { echo >&2 "I require autoreconf but it's not installed.  Aborting."; exit 1; }
command -v aclocal >/dev/null 2>&1 || { echo >&2 "I require aclocal but it's not installed.  Aborting."; exit 1; }
command -v m4 >/dev/null 2>&1 || { echo >&2 "I require m4 but it's not installed.  Aborting."; exit 1; }
command -v awk >/dev/null 2>&1 || { echo >&2 "I require awk but it's not installed.  Aborting."; exit 1; }
command -v gawk >/dev/null 2>&1 || { echo >&2 "I require gawk but it's not installed.  Aborting."; exit 1; }
#using clang + gcc incase one breaks or the user likes one over the other
command -v clang >/dev/null 2>&1 || { echo >&2 "I require clang but it's not installed.  Aborting."; exit 1; }
command -v gcc >/dev/null 2>&1 || { echo >&2 "I require gcc but it's not installed.  Aborting."; exit 1; }
#assuming we haven't exited yet
echo "Found all tools!"
echo "Checking for files." #this needs to be better
if [ -z "$(ls -A xserver)" ]; then
   echo "xserver wasn't pulled!"
   exit 1;
else
   echo "found xserver!"
fi
if [ -z "$(ls -A qemu)" ]; then
	echo "qemu wasn't pulled!"
	exit 1;
else
	echo "found qemu!"
fi
if [ -z "$(ls -A macros)" ]; then
	echo "macros wasn't pulled!"
	exit 1;
else
	echo "found qemu!"
fi
if [ -z "$(ls -A util)" ]; then
	echo "fontutil wasn't pulled!"
	exit 1;
else
	echo "found fontutil!"
fi
echo "Found all files!"
echo "%%% Building"
cd macros
./autogen.sh
make install
cd ..
cd util
./autogen.sh
aclocal --verbose -I /usr/local/share/aclocal
cd xserver
./autogen.sh
aclocal --verbose -I /usr/local/share/aclocal
