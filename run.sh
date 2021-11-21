#!/bin/bash

#SBATCH -q debug
#SBATCH -N 1
#SBATCH -t 10:00
#SBATCH -C knl
#SBATCH -L SCRATCH
#SBATCH -J MITgcm

module swap PrgEnv-cray PrgEnv-intel
module swap craype-haswell craype-mic-knl
module load matlab

cd /global/cscratch1/sd/takaito/mitgcm0

export OMP_NUM_THREADS=1
srun -n 32 -c 1 --cpu_bind=cores ./mitgcmuv

matlab -nojvm -nosplash -r 'drive_rdmds_nc; exit;'


