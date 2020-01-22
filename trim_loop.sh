#!/bin/sh
#SBATCH --time=8:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16 
#SBATCH --mem=40G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bromanje@uwyo.edu
#SBATCH -J trim
#SBATCH --account=hybridpoplar

echo "Loading required modules"
module load gcc swset trimmomatic

### Created Shortcut to the location of input files
filepath="/project/hybridpoplar/fastq"

echo "Beginning trimming at $(date)"

cd $filepath 

for f in sample_*/
do
  cd $f 
  for fwd in *_R1_*fastq.gz
  do 
    echo "the FWD file is: $fwd"
    for rev in *_R2_*fastq.gz
    do
      echo "the REV file is: $rev"
      trimmomatic PE -threads 16 $fwd $rev TFP_$fwd TFU_$fwd TRP_$rev TRU_$rev HEADCROP:10 SLIDINGWINDOW:4:28 MINLEN:60
    done
  done
  cd ..
done

echo "Finished trimming at $(date)"

