# NERSC-MITgcm

### Account admin
iris.nersc.gov

### New user training
[New user orientation](https://www.nersc.gov/users/training/events/new-user-training-june-16-2020/), and many useful knowledge covered in [Recorded presentation](https://www.youtube.com/playlist?list=PL20S5EeApOSsFDfNrshVdiaQKZK4CNFq7)

## MITgcm configuration for NERSC-CORI supercomputer
Successful run using the Intel compiler (tested with 2.8x2.8 global ocean config with 32 cores)

### Working environment: modules
module load PrgEnv-intel
module swap craype-haswell craype-mic-knl

### Working environment: interactive environment

[link to JupyterHub](https://jupyter.nersc.gov/hub/home)

### Compiler option
To compile the MITgcm, using the above module configuration use this: 
Option file [opt_cori_intel]()

### Test run
At the command prompt, salloc -N 1 -q interactive -C knl -t 30:00 

