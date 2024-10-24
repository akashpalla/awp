#!/bin/tcsh



set template = src/awp/mesh_clean.c
if(-e $template)then
cp $template src/awp/mesh.c
endif


rm -r release
mkdir -p release
module load cmake gcc cuda

cd release
cmake ..
make
