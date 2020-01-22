#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=40G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH -J ALN
#SBATCH --account=hybridpoplar

## Shortcuts to input data location
raw="/project/hybridpoplar/grapeseq/fastq"
aln="/gscratch/bromanje/grapeseq/2ht2_aln"
ref="/project/grapeseq/refgenome/inra/ht2_idx"

## Load modules
module load gcc swset hisat2 samtools bamtools

cd $raw

for f in sample_*
do
  cd $f
  echo "Working on $(pwd) beginning at $(date)"
  echo ""
  echo "Aligning $f against the reference"
  echo ""
  mkdir $aln/${f}_aln
  hisat2 -p 16 -x $ref/vitisV2_ht2 -1 TFP*.fastq.gz -2 TRP*.fastq.gz -U TFU*.fastq.gz,TRU*.fastq.gz -S $aln/${f}_aln/${f}_pe+se_ht2.sam
  echo ""
  echo "Generated $(ls -othr $aln/${f}_aln/${f}_pe+se_ht2.sam) on $(date)"
  echo ""
  samtools view -bS $aln/${f}_aln/${f}_pe+se_ht2.sam > $aln/${f}_aln/${f}_pe+se_ht2.bam
  echo "Generating Alignment Stats on ${f}"
  bamtools stats -in $aln/${f}_aln/${f}_pe+se_ht2.bam > $aln/${f}_aln/${f}.alnStats
  echo "Finished working on $f at $(date)"
  echo "==================================================="
  echo ""
  cd ..
done

