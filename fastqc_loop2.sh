#!/bin/bash

#SBATCH --time=8:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=20G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH --account=hybridpoplar

echo "Loading required modules"
module load gcc swset fastqc

###Create shortcut to the location of input files
filepath="/project/hybridpoplar/fastq"


echo "Beginning Fastqc at $(date)"
cd $filepath

for f in sample_* 
do  
  fastqc -t 16  $f/T*.fastq.gz 
done

echo "Finnished Fastqc at $(date)" 
