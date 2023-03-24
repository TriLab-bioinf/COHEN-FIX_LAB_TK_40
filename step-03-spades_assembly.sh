#!/usr/bin/bash
#SBATCH --cpus-per-task=16 --mem=250g --gres=lscratch:500 --time=24:00:00

if [[ -n $1 && $2 ]]; then
    READ_TRIM_DIR=$1
    SAMPLE=$2
elif [[ -z ${SAMPLE} || -z ${READ_TRIM_DIR} ]]; then
    echo $0 "<READ_TRIM_DIR> <SAMPLE>"
    exit 1
fi

FASTQ_1P=`ls ${READ_TRIM_DIR}/${SAMPLE}_1P.fastq.gz`
FASTQ_2P=`ls ${READ_TRIM_DIR}/${SAMPLE}_2P.fastq.gz`

if [[ -e ${READ_TRIM_DIR}/${SAMPLE}_1U.fastq.gz && -e ${READ_TRIM_DIR}/${SAMPLE}_2U.fastq.gz ]]; then
    FASTQ_1U=${READ_TRIM_DIR}/${SAMPLE}_1U.fastq.gz
    FASTQ_2U=${READ_TRIM_DIR}/${SAMPLE}_2U.fastq.gz
    SINGLE="--s1 ${FASTQ_1U} --s2 ${FASTQ_2U}"
else
    SINGLE=""
fi

if [[ ! -d "03-spades" ]]; then
        mkdir "03-spades"
fi        

module load spades/3.15.5 

# Spades optional parameters
OPTIONS='--isolate'
# OPTIONS='--careful --only-assembler'

echo spades.py --cov-cutoff auto -o "03-spades" -1 ${FASTQ_1P} -2 ${FASTQ_2P} ${SINGLE} ${OPTIONS} --threads 16 --memory 246 --tmp-dir /lscratch/$SLURM_JOB_ID \> ${SAMPLE}_spades.log 2\>&1

spades.py --cov-cutoff auto -o "03-spades" -1 ${FASTQ_1P} -2 ${FASTQ_2P} ${SINGLE} ${OPTIONS}  --threads 16 --memory 246 --tmp-dir /lscratch/$SLURM_JOB_ID > ${SAMPLE}_spades.log 2>&1



