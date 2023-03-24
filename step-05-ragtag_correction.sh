#!/bin/bash
set -e

if [[ -n $1 && $2 && $3 ]]; then
    GENOME=$1
    CONTIGS=$2
    LIST=$3
elif [[ -z ${GENOME} || -z ${CONTIGS} || -z ${LIST} ]]; then
    echo $0 "<GENOME> <SCONTIGS> <LIST>"
    exit 1
fi


module load ragtag

# PARAMETERS="--remove-small --gff ${GFF} -o 05-ragtag_correction -t 16 -T sr -F ${LIST}"
PARAMETERS="--remove-small -o 05-ragtag_correction -t 16 -T sr -F ${LIST}"

ragtag.py correct ${PARAMETERS} ${GENOME} ${CONTIGS}
