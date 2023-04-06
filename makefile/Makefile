#------------------------------------------------------------------------------
# 								Modular Makefile
# 
# This Makefile is able to compile several source folders and header folders
# togheter, specified in the "User modifiable variables" section.
# Capabilities:
#	* Multiple source folders.
#	* Multiple header folders.
#	* Recompilation of the whole project if a header file is modified 
#	  (a constant may be defined in a header file which affects several 
#	  source files).
#
# Targets:
#	* run: compile and execute the generated file.
#	* clean | clear: remove compilation files.
#
# Author: Nicolas Gabriel Cotti (ngcotti@gmail.com)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Makefile Initialization
#------------------------------------------------------------------------------
SHELL=/bin/bash
.ONESHELL:
.POSIX:
.EXPORT_ALL_VARIABLES:
.DELETE_ON_ERROR:
.SILENT:

#------------------------------------------------------------------------------
# User modifiable variables
#------------------------------------------------------------------------------
# Compiler to be used to generate object files ".o".
compiler := gcc

# User specific flags.
compiler_flags := -c

# Linker to be used to merge ".o" files.
linker := gcc

# User specific linker flags.
linker_flags := 

# Name of the build directory, where all the compilation files will be put.
build_dir := build

# List of header files' directories (don't use "./").
header_dirs := inc inc/sub_inc

# Suffix for header files
header_extension := .h

# List of source files' directories (don't use "./")
source_dirs := src src/sub_src

# Suffix for source files
source_extension := .c

# Name of the final executable
executable_name := exe

#------------------------------------------------------------------------------
# File location parsing (user shouldn't modify)
#------------------------------------------------------------------------------
# Suffix for object file
object_extension := .o

# Executable file, adding the build directory as prefix
executable_file := ${build_dir}/${executable_name}

# Bash checkmark to be printed
checkmark := printf "\\u2713\n"

# List all source files as "source_dir/source_file"
define source_files !=
	for dir in ${source_dirs}; do
		ls $${dir}/*${source_extension}
	done
endef

# List all header files as "header_dir/header_file"
define header_files !=
	for dir in ${header_dirs}; do
		ls $${dir}/*${header_extension}
	done
endef

# Add "-I" flag in between header direrctorie to pass as arguments to the compiler
define include_headers !=
	for dir in ${header_dirs}; do
		aux="$${aux} -I $${dir}"
	done
	echo "$${aux}"
endef

# List all object files as "build_dir/source_dir/object_file"
define object_files !=
	# Replace source extension for object extension
	for file in ${source_files}; do
		file=$${file//${source_extension}/${object_extension}}

		# Prepend "build_dir" for each source file
		for a in $${file}; do
			echo "${build_dir}/$${a}"
		done
	done
endef

#------------------------------------------------------------------------------
# Compilation targets
#------------------------------------------------------------------------------
# Main executable linking
${executable_file}: ${object_files}
	echo -n "Linking everything together... "
	${linker} ${linker_flags} -o $@ $^
	${checkmark}
	echo "Executable file \"$@\" successfully created."

# Individual object files compiling
${build_dir}/%${object_extension}: %${source_extension} ${header_files}
	# Create compilation folders if they don't exist
	for dir in ${source_dirs}; do
		mkdir -p ${build_dir}/$${dir}
	done
	
	echo -n "Compiling $<... "
	${compiler} ${compiler_flags} -o $@ -c ${include_headers} $<
	${checkmark}

#------------------------------------------------------------------------------
#	Utility targets
#------------------------------------------------------------------------------

# Execute compiled file.
.PHONY: run
run: ${executable_file}
	./$<

# Clean / clear all the previous compilation files.
.PHONY: clean
clean:
	if [ -d $${build_dir} ]; then
		rm -R $${build_dir}
		echo "Removed build files on \"$${build_dir}\" directory"
	else
		echo "No build files detected. Skipping..."
	fi
	
.PHONY: clear
clear: clean
