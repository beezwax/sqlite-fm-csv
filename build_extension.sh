#!/bin/zsh

#	HISTORY
#	2024-06-17 simon_b: created from working script

set -e
sqlitePath="~/sqlite"
csvPath="~/csv_fm"



#TODO: Use -DSQLITE_CORE in main sqlite build so we can staticly link in extension to sqlite binary?

if [[ "$OSTYPE" == "darwin"* ]]; then

	#
	# Need to pull in a copy of SQLite for headers?
	#

	if false; then
		mkdir -p "$sqlitePath"
		pushd "$sqlitePath"
		wget https://www.sqlite.org/src/tarball/sqlite.tar.gz
		tar xzf sqlite.tar.gz
		mkdir -p bld
		cd bld
		../sqlite/configure
		make
		popd
	fi

	# Typically macOS SDKs are at either of these paths (version numbers may be different)
	# You'll need to change to match what you have available.
	#includesPath="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.2.sdk/usr/include"
	includePaths="/Library/Developer/CommandLineTools/SDKs/MacOSX12.1.sdk/usr/include"

	clang -arch x86_64 -arch arm64 -g -I../../Support/sqlite/bld -I"$sdkIncludes" -fPIC -dynamiclib -L../../Support/sqlite/bld -lsqlite3 fm_csv.c -o fm_csv.dylib
	# Use our copy of sqlite, not Apple's
	install_name_tool -change /usr/lib/libsqlite3.dylib @loader_path./libsqlite3.al fm_csv.dylib
	#install_name_tool -change /usr/lib/libsqlite3.dylib @loader_path./bBox fm_csv.dylib

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then

	# Linux
	#TODO: fix for Ubuntu
	# sudo apt install libsqlite3-dev

	includesPath="/usr/include"
	clang -g -I../../Support/sqlite/bld -I"$includes" -fPIC -dynamiclib -L../../Support/sqlite/bld -lsqlite3 fm_csv.c -o fm_csv.dylib

fi



