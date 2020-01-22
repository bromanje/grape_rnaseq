#!/bin/bash
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=40G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH -J Mrg
#SBATCH --account=hybridpoplar

##loading modules
module load gcc swset stringtie

## Building shortcuts
gff="/project/grapeseq/refgenome/inra"
aln="/gscratch/bromanje/grapeseq/2ht2_aln/"
prj="/gscratch/bromanje/grapeseq/2ht2_aln/aln/"

cd $aln 

stringtie --merge -p 16 -G $gff/Vitis_vinifera_gene_annotation_on_V2_20.gff3 -o $prj/merged.gtf $aln/mergelist.txt
