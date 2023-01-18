#!/usr/bin/bash

READ_DIR=$1
SAMPLE=$2

FASTQ1=`ls ${READ_DIR}/${SAMPLE}*R1*fastq.gz`
FASTQ2=`ls ${READ_DIR}/${SAMPLE}*R2*fastq.gz`

if [[ ! -d "01-fastqc" ]]; then
        mkdir "01-fastqc"
fi        

module load fastqc/0.11.9

echo fastqc -o "01-fastqc" -t 2 ${FASTQ1} ${FASTQ2}

fastqc -o "01-fastqc" -t 2 ${FASTQ1} ${FASTQ2}  

