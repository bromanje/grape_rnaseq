#!/bin/bash
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=40G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH -J StrTie
#SBATCH --account=hybridpoplar


## Building shortcuts
aln="/gscratch/bromanje/grapeseq/2ht2_aln/aln/"
gff="/project/grapeseq/refgenome/inra"


##Loading modules
module load gcc swset stringtie

## go to where sample files are
cd $aln

while read s 
do 
  echo "Start stringtie at $(date)"
  stringtie -p 16 -G ${gff}/Vitis_vinifera_gene_annotation_on_V2_20.gff3 -o ${s}_aln/${s}.gtf -l $s ${s}_aln/${s}_sorted.bam -e -C ${s}_aln/${s}_coverage.gtf
  echo "Finished stringtie at $(date)"
  echo "====================================="
done < sample.names
