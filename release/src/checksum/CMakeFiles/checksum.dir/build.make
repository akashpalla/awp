# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.27

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /autofs/nccs-svm1_sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/cmake-3.27.7-zedecrrdzkqtcxzquip2l4ii7n67egan/bin/cmake

# The command to remove a file.
RM = /autofs/nccs-svm1_sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/cmake-3.27.7-zedecrrdzkqtcxzquip2l4ii7n67egan/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release

# Include any dependencies generated for this target.
include src/checksum/CMakeFiles/checksum.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/checksum/CMakeFiles/checksum.dir/compiler_depend.make

# Include the progress variables for this target.
include src/checksum/CMakeFiles/checksum.dir/progress.make

# Include the compile flags for this target's objects.
include src/checksum/CMakeFiles/checksum.dir/flags.make

src/checksum/CMakeFiles/checksum.dir/checksum.c.o: src/checksum/CMakeFiles/checksum.dir/flags.make
src/checksum/CMakeFiles/checksum.dir/checksum.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/checksum.c
src/checksum/CMakeFiles/checksum.dir/checksum.c.o: src/checksum/CMakeFiles/checksum.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/checksum/CMakeFiles/checksum.dir/checksum.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/checksum/CMakeFiles/checksum.dir/checksum.c.o -MF CMakeFiles/checksum.dir/checksum.c.o.d -o CMakeFiles/checksum.dir/checksum.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/checksum.c

src/checksum/CMakeFiles/checksum.dir/checksum.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/checksum.dir/checksum.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/checksum.c > CMakeFiles/checksum.dir/checksum.c.i

src/checksum/CMakeFiles/checksum.dir/checksum.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/checksum.dir/checksum.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/checksum.c -o CMakeFiles/checksum.dir/checksum.c.s

src/checksum/CMakeFiles/checksum.dir/md5/md5.c.o: src/checksum/CMakeFiles/checksum.dir/flags.make
src/checksum/CMakeFiles/checksum.dir/md5/md5.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/md5/md5.c
src/checksum/CMakeFiles/checksum.dir/md5/md5.c.o: src/checksum/CMakeFiles/checksum.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object src/checksum/CMakeFiles/checksum.dir/md5/md5.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/checksum/CMakeFiles/checksum.dir/md5/md5.c.o -MF CMakeFiles/checksum.dir/md5/md5.c.o.d -o CMakeFiles/checksum.dir/md5/md5.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/md5/md5.c

src/checksum/CMakeFiles/checksum.dir/md5/md5.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/checksum.dir/md5/md5.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/md5/md5.c > CMakeFiles/checksum.dir/md5/md5.c.i

src/checksum/CMakeFiles/checksum.dir/md5/md5.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/checksum.dir/md5/md5.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum/md5/md5.c -o CMakeFiles/checksum.dir/md5/md5.c.s

# Object files for target checksum
checksum_OBJECTS = \
"CMakeFiles/checksum.dir/checksum.c.o" \
"CMakeFiles/checksum.dir/md5/md5.c.o"

# External object files for target checksum
checksum_EXTERNAL_OBJECTS =

src/checksum/libchecksum.a: src/checksum/CMakeFiles/checksum.dir/checksum.c.o
src/checksum/libchecksum.a: src/checksum/CMakeFiles/checksum.dir/md5/md5.c.o
src/checksum/libchecksum.a: src/checksum/CMakeFiles/checksum.dir/build.make
src/checksum/libchecksum.a: src/checksum/CMakeFiles/checksum.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C static library libchecksum.a"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && $(CMAKE_COMMAND) -P CMakeFiles/checksum.dir/cmake_clean_target.cmake
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/checksum.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/checksum/CMakeFiles/checksum.dir/build: src/checksum/libchecksum.a
.PHONY : src/checksum/CMakeFiles/checksum.dir/build

src/checksum/CMakeFiles/checksum.dir/clean:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum && $(CMAKE_COMMAND) -P CMakeFiles/checksum.dir/cmake_clean.cmake
.PHONY : src/checksum/CMakeFiles/checksum.dir/clean

src/checksum/CMakeFiles/checksum.dir/depend:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/checksum /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/checksum/CMakeFiles/checksum.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : src/checksum/CMakeFiles/checksum.dir/depend

