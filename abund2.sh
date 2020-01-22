#!/bin/bash
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=20G
#SBATCH --mail-type=NONE
#SBATCH --mail-user=vchhatre@uwyo.edu
#SBATCH -J abund
#SBATCH --account=grapeseq

## Shortcuts to input data location
merg="/gscratch/bromanje/grapeseq/2ht2_aln/aln/"
bam="/gscratch/bromanje/grapeseq/2ht2_aln/aln/"
ballin="/gscratch/bromanje/grapeseq/2ht2_aln/ballgown"

## Load modules
module load gcc swset hisat2 stringtie

cd $bam

while read s
do
  stringtie -e -B -p 16 -G $merg/merged.gtf -o $ballin/${s}_aln/${s}_ballin.gtf $bam/${s}_aln/*_sorted.bam
done < sample.names

