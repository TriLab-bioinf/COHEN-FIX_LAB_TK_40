#!/bin/bash
#SBATCH --mem=10g 
set -e

if [[ -n $1 && $2 ]]; then
    FASTQ=$1
    NUMBER_READS=$2
elif [[ -z ${FASTQ} || -z ${NUMBER_READS} ]]; then
    echo $0 "<READ_DIR> <SAMPLE>"
    exit 1
fi

PREFIX=`basename -s .fastq.gz ${FASTQ}`
READPATH=`echo ${FASTQ%/*}`

if [[ ! -d ${READPATH}/SUBSAMPLE ]]; then
    mkdir ${READPATH}/SUBSAMPLE
fi    

module load seqtk

PARAMETERS="-s 123"

echo seqtk sample ${PARAMETERS} ${FASTQ} ${NUMBER_READS} \| gzip \> ${READPATH}/SUBSAMPLE/${PREFIX}.fastq.gz

seqtk sample ${PARAMETERS} ${FASTQ} ${NUMBER_READS} | gzip > ${READPATH}/SUBSAMPLE/${PREFIX}.fastq.gz

