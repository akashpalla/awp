#!/bin/bash    
build=$1
analysis=$2
dir=logs/mapping
submit=analysis
nz=256

if [ $build == 1 ]
then
git fetch && git fetch --tags
git checkout v1.0.1
mkdir -p release
cd release; cmake -DCMAKE_BUILD_TYPE=Release ..; make clean; make; cd -
fi

if [ $analysis == 1 ]
then
nvflags="--profile-from-start off --analysis-metrics"
submit=analysis
else
nvflags="--profile-from-start off"
submit=profile
fi


mkdir -p ${dir}

echo "#!/bin/bash" > $dir/${submit}.sh

for nx in 100 200 300 400 500 600
do
        for ny in 100 200 300 400 500 600
        do
                filename=${submit}_${nx}_${ny}.lsf
echo "#!/bin/bash
# Begin LSF Directives
#BSUB -P geo112
#BSUB -W 0:20
#BSUB -nnodes 1
#BSUB -alloc_flags gpumps
#BSUB -J profile
#BSUB -o ${dir}/profile_${nx}_${ny}.out
#BSUB -e ${dir}/profile_${nx}_${ny}.err
                
module load cuda

#cd $LS_SUBCWD
bash scripts/run.sh ${dir} \"${nvflags}\" ${nx} ${ny} ${nz}
" >    \
$dir/${filename}_${nx}_${ny}.lsf

echo "bsub $dir/${filename}_${nx}_${ny}.lsf
" >> $dir/${submit}.sh
        done
done
