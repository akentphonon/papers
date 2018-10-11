#!/bin/bash
#PBS -l nodes=2:ppn=16
#PBS -l walltime=120:00:00
#PBS -N cu11sb3
#PBS -m bae
#PBS -M xinlei.liu@seh.ox.ac.uk


module load espresso/5.3.0

# develq - short queue with walltime 10 minutes and maximum 2 nodes
# to submit to develq: qsub -q develq script.pbs

# Set up mpi on ARCUS
. enable_arcus_mpi.sh


# Executable aliases
export MPI_GROUP_MAX=64


# Copy to TMPDIR all files required for start
cd $PBS_O_WORKDIR


foreach NLINE ( `seq 1 15` )
cp cu11sb3-scf.in cu11sb3-scf-${NLINE}.in
head -${NLINE} cu11sb31_kp.txt | tail -1 >> cu11sb3-scf-${NLINE}.in
$MPIRUN -np $NSLOTS $PW < cu11sb3-scf-${NLINE}.in > cu11sb3-scf-${NLINE}.out
end