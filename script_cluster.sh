#!/bin/bash
#
stics_version="V9.1"
javastics_path="/home/emmah/gpouget/JavaSTICS-1.41-stics-9.1"
var_names=c\(\"masec_n\",\"mafruit\"\)
ncoeurs=2
#
rep_multisimu=\"`pwd`\/multisimulation\"
stics_version=\"${stics_version}\"
javastics_path=\"${javastics_path}\"
#
RES1=$(sbatch --parsable --nodes=1 --cpus-per-task=1 jobSLURM_1.sh $rep_multisimu $stics_version $javastics_path)
RES2=$(sbatch --parsable --dependency=afterok:$RES1 --array=1-$ncoeurs --nodes=1 --cpus-per-task=1 jobSLURM_2.sh $rep_multisimu $javastics_path $var_names $ncoeurs)
sbatch --dependency=afterany:$RES2 --nodes=1 --cpus-per-task=1 jobSLURM_3.sh $rep_multisimu $ncoeurs
