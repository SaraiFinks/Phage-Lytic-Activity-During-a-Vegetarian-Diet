#!/bin/bash

#SBATCH --job-name=fastqc_mic
#SBATCH -A one
#SBATCH --mail-type=ALL
#SBATCH --mail-user=@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=16
#SBATCH --mem=250G
#SBATCH --time=48:00:00
#SBATCH --array=1-220

module load fastqc/0.11.9

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

### FASTQC ###
	echo "########## FASTQC ##########"
	fastqc ${ANALYSIS_PATH}/${fread} ${ANALYSIS_PATH}/${rread} \
	-o $OUTDIR_PATH