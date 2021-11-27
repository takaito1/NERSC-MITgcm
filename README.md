# NERSC-MITgcm

### Account admin
iris.nersc.gov

### New user training
[New user orientation](https://www.nersc.gov/users/training/events/new-user-training-june-16-2020/), and many useful knowledge covered in [Recorded presentation](https://www.youtube.com/playlist?list=PL20S5EeApOSsFDfNrshVdiaQKZK4CNFq7)

## MITgcm configuration for NERSC-CORI supercomputer
Successful run using the Intel compiler (tested with 2.8x2.8 global ocean config with 32 cores)

### Working environment: modules
* module load PrgEnv-intel
* module swap craype-haswell craype-mic-knl

### JupyterHub: much better than SSH
* [link to JupyterHub](https://jupyter.nersc.gov/hub/home)

### Compiler option
To compile the MITgcm, using the above module configuration use this: 
* Download the source code and compile one of the verification example using theh following option file: 
* Option file [opt_cori_intel](https://github.com/takaito1/NERSC-MITgcm/blob/main/code/opt_cori_intel)

### Test run
At the command prompt,
> salloc -N 1 -q interactive -C knl -t 30:00 
> 
> srun -n 32 ./mitgcmuv

### postprocessing 
Binary to netCDF can be done automatically using the following scripts: 
* [rdmds.m](https://github.com/takaito1/NERSC-MITgcm/blob/main/code/rdmds.m) Do not edit
* [rdmds_nc_batch.m](https://github.com/takaito1/NERSC-MITgcm/blob/main/code/rdmds_nc_batch.m) Do not edit
* [drive_rdmds_nc.m](https://github.com/takaito1/NERSC-MITgcm/blob/main/code/drive_rdmds_nc.m) Edit this file for the desired variables

### Slurm job script
Once everything works on the interactive mode, it is ready to submit in the batch mode: 
[run.sh](https://github.com/takaito1/NERSC-MITgcm/blob/main/code/run.sh)
> sbatch run.sh
