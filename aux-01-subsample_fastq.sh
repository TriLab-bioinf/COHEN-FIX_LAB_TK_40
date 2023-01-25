#!/bin/bash
#SBATCH --mem=10g 
set -e

FASTQ=$1
NUMBER_READS=$2
PREFIX=`basename -s .fastq.gz ${FASTQ}`
READPATH=`echo ${FASTQ%/*}`

if [[ ! -d ${READPATH}/SUBSAMPLE ]]; then
    mkdir ${READPATH}/SUBSAMPLE
fi    

module load seqtk

PARAMETERS="-s 123"

echo seqtk sample ${PARAMETERS} ${FASTQ} ${NUMBER_READS} \> ${READPATH}/SUBSAMPLE/${PREFIX}.fastq.gz

seqtk sample ${PARAMETERS} ${FASTQ} ${NUMBER_READS} > ${READPATH}/SUBSAMPLE/${PREFIX}.fastq.gz

