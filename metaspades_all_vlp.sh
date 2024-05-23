#!/bin/bash

#SBATCH --job-name=metaspades_all_vlp
#SBATCH -A open
#SBATCH --mail-type=ALL
#SBATCH --mail-user=@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=48
#SBATCH --mem=250G
#SBATCH --time=48:00:00
#SBATCH -o myoutput_%j.out          
#SBATCH -e myerrors_%j.err
#SBATCH --array=1-186

export SPADES_PATH=/path/to/spades_program
export ANALYSIS_PATH=/path/to/files
export OUTDIR_PATH=/path/to/output

file1=$(ls ${ANALYSIS_PATH}/*_R1.fq | sed -n ${SLURM_ARRAY_TASK_ID}p)

### EXTRACT SEQUENCE FILES ###
fread="${file1##*/}"
rread=${fread%%_R1.fq}"_R2.fq"
filename=${fread%%_R1.fq}""
echo "###################################################################"
date '+%A %W %Y %X'
echo "########## ACTING ON FILES ##########"
echo "$fread"
echo "$rread"
echo "$filename"

### METAVIRAL SPADES ###
echo "########## ASSEMBLIES ##########"
${SPADES_PATH}/metaspades.py -1 ${ANALYSIS_PATH}/${fread} -2 ${ANALYSIS_PATH}/${rread} \
-t 48 \
-o ${OUTDIR_PATH}/${filename}

