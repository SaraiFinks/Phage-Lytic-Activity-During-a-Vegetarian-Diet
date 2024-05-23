#!/bin/bash

#SBATCH --job-name=genomad_vlp
#SBATCH -A one
#SBATCH --mail-type=ALL
#SBATCH --mail-user=@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=24
#SBATCH --mem=256GB
#SBATCH --time=500:00:00

module load anaconda3/2021.05
source activate genomad

WORKDR=/path/to/files
OUTDR=/path/to/output
DB=/path/to/genomad_database


cd $WORKDR


for ffile in *.fasta

do

	genomad end-to-end --cleanup \
	--splits 8 $ffile $OUTDR/genomad_output $DB

done






