#!/bin/bash

#   #SBATCH --partition=defq
#SBATCH --output=multi3_%A.out # Name of the output file
#SBATCH --error=multi3_%A.err # Name of the stderr file (sortie standard des erreurs de OGE)
#SBATCH --job-name=multi3 # Name of this Job in the qstat output (can be anything … sample string)


### TO BE LAUNCHED USING sbatch --nodes=1 --cpus-per-task=1 jobSLURM_3.sh

ml R/4.0.0

echo $1
echo $2

Rscript script_gather.R rep_multisimu=$1 ncoeurs=$2