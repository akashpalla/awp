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
include tests/readers/CMakeFiles/test_version.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/readers/CMakeFiles/test_version.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/readers/CMakeFiles/test_version.dir/progress.make

# Include the compile flags for this target's objects.
include tests/readers/CMakeFiles/test_version.dir/flags.make

tests/readers/CMakeFiles/test_version.dir/test_version.c.o: tests/readers/CMakeFiles/test_version.dir/flags.make
tests/readers/CMakeFiles/test_version.dir/test_version.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/readers/test_version.c
tests/readers/CMakeFiles/test_version.dir/test_version.c.o: tests/readers/CMakeFiles/test_version.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/readers/CMakeFiles/test_version.dir/test_version.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tests/readers/CMakeFiles/test_version.dir/test_version.c.o -MF CMakeFiles/test_version.dir/test_version.c.o.d -o CMakeFiles/test_version.dir/test_version.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/readers/test_version.c

tests/readers/CMakeFiles/test_version.dir/test_version.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test_version.dir/test_version.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/readers/test_version.c > CMakeFiles/test_version.dir/test_version.c.i

tests/readers/CMakeFiles/test_version.dir/test_version.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test_version.dir/test_version.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/readers/test_version.c -o CMakeFiles/test_version.dir/test_version.c.s

# Object files for target test_version
test_version_OBJECTS = \
"CMakeFiles/test_version.dir/test_version.c.o"

# External object files for target test_version
test_version_EXTERNAL_OBJECTS =

tests/readers/test_version: tests/readers/CMakeFiles/test_version.dir/test_version.c.o
tests/readers/test_version: tests/readers/CMakeFiles/test_version.dir/build.make
tests/readers/test_version: src/test/libtesting.a
tests/readers/test_version: src/readers/libreaders.a
tests/readers/test_version: /sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/spectrum-mpi-10.4.0.6-20230210-f3ouht4ckff2qogy74bwki5ovljfou36/lib/libmpiprofilesupport.so
tests/readers/test_version: /sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/spectrum-mpi-10.4.0.6-20230210-f3ouht4ckff2qogy74bwki5ovljfou36/lib/libmpi_ibm.so
tests/readers/test_version: tests/readers/CMakeFiles/test_version.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable test_version"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_version.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/readers/CMakeFiles/test_version.dir/build: tests/readers/test_version
.PHONY : tests/readers/CMakeFiles/test_version.dir/build

tests/readers/CMakeFiles/test_version.dir/clean:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers && $(CMAKE_COMMAND) -P CMakeFiles/test_version.dir/cmake_clean.cmake
.PHONY : tests/readers/CMakeFiles/test_version.dir/clean

tests/readers/CMakeFiles/test_version.dir/depend:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/readers /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/readers/CMakeFiles/test_version.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests/readers/CMakeFiles/test_version.dir/depend

