#!/bin/bash

#SBATCH --job-name=vlp_sra_fastp
#SBATCH -A open
#SBATCH --mail-type=ALL
#SBATCH --mail-user=@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=16
#SBATCH --mem=250G
#SBATCH --time=48:00:00
#SBATCH -o myoutput_%j.out          
#SBATCH -e myerrors_%j.err
#SBATCH --array=1-186

module load anaconda3/2021.05
source activate fastp

export ANALYSIS_PATH=/path/to/files
export OUTDIR_PATH=/path/to/output

file1=$(ls ${ANALYSIS_PATH}/*_1.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)

### EXTRACT SEQUENCE FILES ###
	fread="${file1##*/}"
	rread=${fread%%_1.fastq.gz}"_2.fastq.gz"
	filename=${fread%%_1.fastq.gz}""
	echo "###################################################################"
	date '+%A %W %Y %X'
	echo "########## ACTING ON FILES ##########"
	echo "$fread"
	echo "$rread"
	echo "$filename"

### FASTP ###
	echo "########## FASTP ##########"
	fastp -i ${ANALYSIS_PATH}/${fread} -I ${ANALYSIS_PATH}/${rread} \
	--average_qual 34 \
	--length_required 50 \
	--detect_adapter_for_pe \
	--correction \
	--unpaired1 $OUTDIR_PATH/${filename} \
	--unpaired2 $OUTDIR_PATH/${filename} \
	--html $OUTDIR_PATH/${filename}_fastp.html \
	-o $OUTDIR_PATH/${filename}_R1.fastq.gz \
	-O $OUTDIR_PATH/${filename}_R2.fastq.gz
