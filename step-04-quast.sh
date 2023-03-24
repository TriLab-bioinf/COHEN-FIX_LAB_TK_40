#!/usr/bin/bash
#SBATCH --cpus-per-task=18 --time=24:00:00

if [[ -n $1 && $2 && $3 && $4 ]]; then
    GENOME=$1
    ANNOTATION=$2
    SAMPLE=$3
    CONTIGS=$4
elif [[ -z ${SAMPLE} || -z ${GENOME} || -z ${ANNOTATION} || -z ${CONTIGS} ]]; then
    echo $0 "<GENOME> <ANNOTATION> <SAMPLE> <CONTIGS>"
    exit 1
fi

# Load quast
module load quast/5.2.0 R

quast.py --output-dir 04-quast -r ${GENOME} -g gene:${ANNOTATION} --threads 16 --fungus --gene-finding --pe1 ./02-trimmed/${SAMPLE}_1P.fastq.gz --pe2 ./02-trimmed/${SAMPLE}_2P.fastq.gz ${CONTIGS} > ${SAMPLE}_quast.log 2>&1



