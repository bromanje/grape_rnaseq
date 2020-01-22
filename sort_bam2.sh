#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=40G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromane@uwyo.edu
#SBATCH -J Sortht2
#SBATCH --account=hybridpoplar



## Shorcuts to input data location
aln="/gscratch/bromanje/grapeseq/2ht2_aln"



## Load modules
module load gcc swset samtools bamtools


cd $aln

while read s
do
samtools sort ${s}_aln/${s}_pe+se_ht2.bam -o ${s}_aln/${s}_sorted.bam
  samtools index ${s}_aln/${s}_sorted.bam
  echo "finished at $(date)"
done < sample.names20

