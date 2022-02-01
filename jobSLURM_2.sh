#!/bin/bash

#   #SBATCH --partition=defq
#SBATCH --output=multi2_%A.out # Name of the output file
#SBATCH --error=multi2_%A.err # Name of the stderr file (sortie standard des erreurs de OGE)
#SBATCH --job-name=multi2 # Name of this Job in the qstat output (can be anything … sample string)


### TO BE LAUNCHED USING sbatch --array=1-2 --nodes=1 --cpus-per-task=7 jobSLURM_2.sh

ml R/4.0.0

echo $1
echo $2
echo $3
echo $4
echo $SLURM_ARRAY_TASK_ID

Rscript script_multisim_txt2results.R rep_multisimu=$1 javastics_path=$2 var_names=$3 ncoeurs=$4 i=$SLURM_ARRAY_TASK_ID