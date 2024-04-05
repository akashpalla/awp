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
include src/topography/geometry/CMakeFiles/geometry.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/topography/geometry/CMakeFiles/geometry.dir/compiler_depend.make

# Include the progress variables for this target.
include src/topography/geometry/CMakeFiles/geometry.dir/progress.make

# Include the compile flags for this target's objects.
include src/topography/geometry/CMakeFiles/geometry.dir/flags.make

src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.o: src/topography/geometry/CMakeFiles/geometry.dir/flags.make
src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/geometry/geometry.c
src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.o: src/topography/geometry/CMakeFiles/geometry.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.o -MF CMakeFiles/geometry.dir/geometry.c.o.d -o CMakeFiles/geometry.dir/geometry.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/geometry/geometry.c

src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/geometry.dir/geometry.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/geometry/geometry.c > CMakeFiles/geometry.dir/geometry.c.i

src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/geometry.dir/geometry.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/geometry/geometry.c -o CMakeFiles/geometry.dir/geometry.c.s

# Object files for target geometry
geometry_OBJECTS = \
"CMakeFiles/geometry.dir/geometry.c.o"

# External object files for target geometry
geometry_EXTERNAL_OBJECTS =

src/topography/geometry/libgeometry.a: src/topography/geometry/CMakeFiles/geometry.dir/geometry.c.o
src/topography/geometry/libgeometry.a: src/topography/geometry/CMakeFiles/geometry.dir/build.make
src/topography/geometry/libgeometry.a: src/topography/geometry/CMakeFiles/geometry.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libgeometry.a"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry && $(CMAKE_COMMAND) -P CMakeFiles/geometry.dir/cmake_clean_target.cmake
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/geometry.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/topography/geometry/CMakeFiles/geometry.dir/build: src/topography/geometry/libgeometry.a
.PHONY : src/topography/geometry/CMakeFiles/geometry.dir/build

src/topography/geometry/CMakeFiles/geometry.dir/clean:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry && $(CMAKE_COMMAND) -P CMakeFiles/geometry.dir/cmake_clean.cmake
.PHONY : src/topography/geometry/CMakeFiles/geometry.dir/clean

src/topography/geometry/CMakeFiles/geometry.dir/depend:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/geometry /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/geometry/CMakeFiles/geometry.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : src/topography/geometry/CMakeFiles/geometry.dir/depend

