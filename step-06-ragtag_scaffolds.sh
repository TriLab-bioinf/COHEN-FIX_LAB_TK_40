#!/bin/bash
set -e

GENOME=$1
CONTIGS=$2

module load ragtag

PARAMETERS="--remove-small -f 1000 -i 0.5 -o 06-ragtag_scaffolds -u -t 16"

ragtag.py scaffold ${PARAMETERS} ${GENOME} ${CONTIGS}

