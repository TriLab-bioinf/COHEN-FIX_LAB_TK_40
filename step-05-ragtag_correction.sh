#!/bin/bash
set -e

GENOME=$1
GFF=$2
CONTIGS=$3
LIST=$4

module load ragtag

# PARAMETERS="--remove-small --gff ${GFF} -o 05-ragtag_correction -t 16 -T sr -F ${LIST}"
PARAMETERS="--remove-small -o 05-ragtag_correction -t 16 -T sr -F ${LIST}"

ragtag.py correct ${PARAMETERS} ${GENOME} ${CONTIGS}
