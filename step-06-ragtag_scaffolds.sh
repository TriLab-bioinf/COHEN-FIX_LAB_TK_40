#!/bin/bash
set -e

if [[ -n $1 && $2 ]]; then
    GENOME=$1
    CONTIGS=$2
elif [[ -z ${GENOME} || -z ${CONTIGS} ]]; then
    echo $0 "<GENOME> <CONTIGS>"
    exit 1
fi

module load ragtag

PARAMETERS="--remove-small -f 1000 -i 0.5 -o 06-ragtag_scaffolds -u -t 16"

ragtag.py scaffold ${PARAMETERS} ${GENOME} ${CONTIGS}

