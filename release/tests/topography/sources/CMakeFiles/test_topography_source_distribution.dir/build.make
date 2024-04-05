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
include tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/progress.make

# Include the compile flags for this target's objects.
include tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/flags.make

tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/flags.make
tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/topography/sources/test_source_distribution.c
tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o -MF CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o.d -o CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/topography/sources/test_source_distribution.c

tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/topography/sources/test_source_distribution.c > CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.i

tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/topography/sources/test_source_distribution.c -o CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.s

# Object files for target test_topography_source_distribution
test_topography_source_distribution_OBJECTS = \
"CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o"

# External object files for target test_topography_source_distribution
test_topography_source_distribution_EXTERNAL_OBJECTS =

tests/topography/sources/test_topography_source_distribution: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/test_source_distribution.c.o
tests/topography/sources/test_topography_source_distribution: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/build.make
tests/topography/sources/test_topography_source_distribution: src/topography/libtopography.a
tests/topography/sources/test_topography_source_distribution: src/buffers/libbuffers.a
tests/topography/sources/test_topography_source_distribution: /sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/spectrum-mpi-10.4.0.6-20230210-f3ouht4ckff2qogy74bwki5ovljfou36/lib/libmpiprofilesupport.so
tests/topography/sources/test_topography_source_distribution: /sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/spectrum-mpi-10.4.0.6-20230210-f3ouht4ckff2qogy74bwki5ovljfou36/lib/libmpi_ibm.so
tests/topography/sources/test_topography_source_distribution: src/test/libtesting.a
tests/topography/sources/test_topography_source_distribution: src/topography/geometry/libgeometry.a
tests/topography/sources/test_topography_source_distribution: src/topography/readers/libtopography_readers.a
tests/topography/sources/test_topography_source_distribution: src/vtk/libvtk.a
tests/topography/sources/test_topography_source_distribution: src/topography/receivers/libtopography_receivers.a
tests/topography/sources/test_topography_source_distribution: src/topography/sources/libtopography_sources.a
tests/topography/sources/test_topography_source_distribution: src/buffers/libbuffers.a
tests/topography/sources/test_topography_source_distribution: src/topography/metrics/libmetrics.a
tests/topography/sources/test_topography_source_distribution: src/interpolation/libinterpolation.a
tests/topography/sources/test_topography_source_distribution: src/topography/libmapping.a
tests/topography/sources/test_topography_source_distribution: src/mpi/libmpi.a
tests/topography/sources/test_topography_source_distribution: src/readers/libreaders.a
tests/topography/sources/test_topography_source_distribution: src/awp/liberror.a
tests/topography/sources/test_topography_source_distribution: src/topography/functions/libfunctions.a
tests/topography/sources/test_topography_source_distribution: src/grid/libgrid.a
tests/topography/sources/test_topography_source_distribution: /sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/spectrum-mpi-10.4.0.6-20230210-f3ouht4ckff2qogy74bwki5ovljfou36/lib/libmpiprofilesupport.so
tests/topography/sources/test_topography_source_distribution: /sw/summit/spack-envs/summit-plus/opt/gcc-8.5.0/spectrum-mpi-10.4.0.6-20230210-f3ouht4ckff2qogy74bwki5ovljfou36/lib/libmpi_ibm.so
tests/topography/sources/test_topography_source_distribution: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/linkLibs.rsp
tests/topography/sources/test_topography_source_distribution: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/objects1.rsp
tests/topography/sources/test_topography_source_distribution: tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CUDA executable test_topography_source_distribution"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_topography_source_distribution.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/build: tests/topography/sources/test_topography_source_distribution
.PHONY : tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/build

tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/clean:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources && $(CMAKE_COMMAND) -P CMakeFiles/test_topography_source_distribution.dir/cmake_clean.cmake
.PHONY : tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/clean

tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/depend:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/tests/topography/sources /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : tests/topography/sources/CMakeFiles/test_topography_source_distribution.dir/depend

