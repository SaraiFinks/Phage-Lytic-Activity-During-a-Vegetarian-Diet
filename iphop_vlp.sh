#!/bin/bash

#SBATCH --job-name=iphop_vlp
#SBATCH -A one
#SBATCH --mail-type=ALL
#SBATCH --mail-user=@psu.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH	--cpus-per-task=24
#SBATCH --mem=256GB
#SBATCH --time=500:00:00

module load anaconda/2021.11
conda activate iphop_env 

WORKDR=/path/to/files
OUTDR=/path/to/output
DB=/path/to/iphop_db/Aug_2023_pub_rw

cd $WORKDR

iphop predict --fa_file vlp_simper.fasta \
--db_dir ${DB} \
--out_dir ${OUTDR}
