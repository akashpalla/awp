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
include src/topography/sources/CMakeFiles/topography_sources.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/topography/sources/CMakeFiles/topography_sources.dir/compiler_depend.make

# Include the progress variables for this target.
include src/topography/sources/CMakeFiles/topography_sources.dir/progress.make

# Include the compile flags for this target's objects.
include src/topography/sources/CMakeFiles/topography_sources.dir/flags.make

src/topography/sources/CMakeFiles/topography_sources.dir/source.c.o: src/topography/sources/CMakeFiles/topography_sources.dir/flags.make
src/topography/sources/CMakeFiles/topography_sources.dir/source.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/source.c
src/topography/sources/CMakeFiles/topography_sources.dir/source.c.o: src/topography/sources/CMakeFiles/topography_sources.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/topography/sources/CMakeFiles/topography_sources.dir/source.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/topography/sources/CMakeFiles/topography_sources.dir/source.c.o -MF CMakeFiles/topography_sources.dir/source.c.o.d -o CMakeFiles/topography_sources.dir/source.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/source.c

src/topography/sources/CMakeFiles/topography_sources.dir/source.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/topography_sources.dir/source.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/source.c > CMakeFiles/topography_sources.dir/source.c.i

src/topography/sources/CMakeFiles/topography_sources.dir/source.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/topography_sources.dir/source.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/source.c -o CMakeFiles/topography_sources.dir/source.c.s

src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.o: src/topography/sources/CMakeFiles/topography_sources.dir/flags.make
src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/sources.c
src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.o: src/topography/sources/CMakeFiles/topography_sources.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.o -MF CMakeFiles/topography_sources.dir/sources.c.o.d -o CMakeFiles/topography_sources.dir/sources.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/sources.c

src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/topography_sources.dir/sources.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/sources.c > CMakeFiles/topography_sources.dir/sources.c.i

src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/topography_sources.dir/sources.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/sources.c -o CMakeFiles/topography_sources.dir/sources.c.s

src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o: src/topography/sources/CMakeFiles/topography_sources.dir/flags.make
src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o: src/topography/sources/CMakeFiles/topography_sources.dir/includes_CUDA.rsp
src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/source.cu
src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o: src/topography/sources/CMakeFiles/topography_sources.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CUDA object src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /sw/summit/cuda/11.7.1/bin/nvcc -forward-unknown-to-host-compiler $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -MD -MT src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o -MF CMakeFiles/topography_sources.dir/source.cu.o.d -x cu -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/source.cu -o CMakeFiles/topography_sources.dir/source.cu.o

src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CUDA source to CMakeFiles/topography_sources.dir/source.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CUDA source to assembly CMakeFiles/topography_sources.dir/source.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.o: src/topography/sources/CMakeFiles/topography_sources.dir/flags.make
src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.o: /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/forces.c
src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.o: src/topography/sources/CMakeFiles/topography_sources.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.o"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.o -MF CMakeFiles/topography_sources.dir/forces.c.o.d -o CMakeFiles/topography_sources.dir/forces.c.o -c /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/forces.c

src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/topography_sources.dir/forces.c.i"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/forces.c > CMakeFiles/topography_sources.dir/forces.c.i

src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/topography_sources.dir/forces.c.s"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources/forces.c -o CMakeFiles/topography_sources.dir/forces.c.s

# Object files for target topography_sources
topography_sources_OBJECTS = \
"CMakeFiles/topography_sources.dir/source.c.o" \
"CMakeFiles/topography_sources.dir/sources.c.o" \
"CMakeFiles/topography_sources.dir/source.cu.o" \
"CMakeFiles/topography_sources.dir/forces.c.o"

# External object files for target topography_sources
topography_sources_EXTERNAL_OBJECTS =

src/topography/sources/libtopography_sources.a: src/topography/sources/CMakeFiles/topography_sources.dir/source.c.o
src/topography/sources/libtopography_sources.a: src/topography/sources/CMakeFiles/topography_sources.dir/sources.c.o
src/topography/sources/libtopography_sources.a: src/topography/sources/CMakeFiles/topography_sources.dir/source.cu.o
src/topography/sources/libtopography_sources.a: src/topography/sources/CMakeFiles/topography_sources.dir/forces.c.o
src/topography/sources/libtopography_sources.a: src/topography/sources/CMakeFiles/topography_sources.dir/build.make
src/topography/sources/libtopography_sources.a: src/topography/sources/CMakeFiles/topography_sources.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CUDA static library libtopography_sources.a"
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && $(CMAKE_COMMAND) -P CMakeFiles/topography_sources.dir/cmake_clean_target.cmake
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/topography_sources.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/topography/sources/CMakeFiles/topography_sources.dir/build: src/topography/sources/libtopography_sources.a
.PHONY : src/topography/sources/CMakeFiles/topography_sources.dir/build

src/topography/sources/CMakeFiles/topography_sources.dir/clean:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources && $(CMAKE_COMMAND) -P CMakeFiles/topography_sources.dir/cmake_clean.cmake
.PHONY : src/topography/sources/CMakeFiles/topography_sources.dir/clean

src/topography/sources/CMakeFiles/topography_sources.dir/depend:
	cd /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/src/topography/sources /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources /ccs/home/dean316/AWP_code_archive/gpu/awp_topo/awp/release/src/topography/sources/CMakeFiles/topography_sources.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : src/topography/sources/CMakeFiles/topography_sources.dir/depend

