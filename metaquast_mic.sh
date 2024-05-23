#!/bin/bash

#SBATCH --job-name=metaquast_mic
#SBATCH -A one
#SBATCH --mail-type=ALL
#SBATCH --mail-user=@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=32
#SBATCH --mem=256GB
#SBATCH --time=190:00:00

module load anaconda3/2021.05
source activate quast

WORKDIR=/path/to/files

#the test_data folder must be located in the same working directory as your data

cd $WORKDIR

for ffile in *.fasta

    do

        basefileID=${ffile%.fasta}

        metaquast.py ${basefileID}.fasta \
        -r meta_ref_1.fasta,meta_ref_2.fasta,meta_ref_3.fasta \
        -o quast_test_output_${basefileID}

    done

