#!/bin/bash

#SBATCH --time=8:00:00
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH --account=hybridpoplar

module load gcc swset hisat2
cd /project/grapeseq/refgenome/inra

hisat2-build 12Xv2_grapevine_genome_assembly.fa ht2_idx/ 
