#!/bin/bash

#SBATCH --time=8:00:00
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH --account=hybridpoplar

echo "Loading required modules"
module load gcc swset fastqc

###Create shortcut to the locatio of input files
filepath="/project/hybridpoplar/fastq"


echo "Beginning Fastqc at $(date)"
cd $filepath

for f in sample* 
do  
  fastqc -t 16  $f/*.fastq.gz 
done

echo "Finished Fastqc at $(date)" 
