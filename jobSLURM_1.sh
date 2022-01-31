#!/bin/bash

#   #SBATCH --partition=defq
#SBATCH --output=multi1_%A.out # Name of the output file
#SBATCH --error=multi1_%A.err # Name of the stderr file (sortie standard des erreurs de OGE)
#SBATCH --job-name=multi1 # Name of this Job in the qstat output (can be anything … sample string)


### TO BE LAUNCHED USING sbatch --nodes=1 --cpus-per-task=1 jobSLURM_1.sh

ml R/4.0.0

echo $1
echo $2
echo $3
echo $4

Rscript script_multisim_excel2txt.R rep_multisimu=$1 stics_version=$2 javastics_path=$3 option_effacement_fichiers=$4