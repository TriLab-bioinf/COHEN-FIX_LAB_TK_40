#!/usr/bin/bash
#SBATCH --time=24:00:00 --mem=32g --cpus-per-task=8

if [[ -n $1 && $2 && $3 ]]; then
    READ_DIR=$1
    SAMPLE=$2
    ADAPTERS=$3
elif [[ -z ${SAMPLE} || -z ${READ_DIR} || -z ${ADAPTERS} ]]; then
    echo $0 "<READ_DIR> <SAMPLE>"
    exit 1
fi

FASTQ1=`ls ${READ_DIR}/${SAMPLE}*R1*fastq.gz`
FASTQ2=`ls ${READ_DIR}/${SAMPLE}*R2*fastq.gz`

if [[ ! -d "02-trimmed" ]]; then
        mkdir "02-trimmed"
fi        

module load trimmomatic/0.39

# PE [-version] [-threads <threads>] [-phred33|-phred64] [-trimlog <trimLogFile>] [-summary <statsSummaryFile>] [-quiet] [-validatePairs] [-basein <inputBase> | <inputFile1> <inputFile2>] [-baseout <outputBase> | <outputFile1P> <outputFile1U> <outputFile2P> <outputFile2U>] <trimmer1>...

echo trimmomatic PE -threads 8 -trimlog ${SAMPLE}.trimmomatic.log -summary ${SAMPLE}.trimmomatic.summary.txt ${FASTQ1} ${FASTQ2} -baseout ./02-trimmed/${SAMPLE}.fastq.gz ILLUMINACLIP:${ADAPTERS}:2:30:10 SLI    DINGWINDOW:4:20 MINLEN:50

trimmomatic PE -threads 8 -trimlog ${SAMPLE}.trimmomatic.log -summary ${SAMPLE}.trimmomatic.summary.txt ${FASTQ1} ${FASTQ2} -baseout ./02-trimmed/${SAMPLE}.fastq.gz ILLUMINACLIP:${ADAPTERS}:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50

