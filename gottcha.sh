#!/bin/bash

#SBATCH --job-name=gottcha
#SBATCH -A one
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ssf5197@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=48
#SBATCH --mem=256GB
#SBATCH --time=48:00:00

module load anaconda3/2021.05
source activate gottcha

WORKDIR=/path/to/files
OUTDIR=/path/to/output
DBPATH=/path/to/GOTTCHA_database/


cd $WORKDIR

#note we need to use interleaved read files for these.

for ffile in *.fastq
do

basefileID=${ffile%.fastq}

gottcha.pl \
	--threads 48 \
      --outdir $OUTDIR/${basefileID} \
      --input ${basefileID}.fastq \
      --database $DBPATH/GOTTCHA_BACTERIA_c4937_k24_u30_xHUMAN3x.species

done

