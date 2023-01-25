# COHEN-FIX_LAB_TK_40

### Generate QC reports for fastq files
```
sbatch step-01-fastqc.sh <path to raw reads directory> <sample name>
```

### Remove adapters and trim reads based on sequencing quality values
```
sbatch step-02-trim_reads.sh <path to raw reads directory> <sample name> <adapter fasta file>
```

### subsample reads up to 15M (enough for assembly: > 100x coverage )
```
sbatch aux-01-subsample_fastq.sh ./02-trimmed/<sample name>_1P.fastq.gz  15000000
sbatch aux-01-subsample_fastq.sh ./02-trimmed/<sample name>_2P.fastq.gz  15000000
```

### Perform assembly with "spades"
```
sbatch step-03-spades_assembly.sh <path to trimmed reads directory> <sample name>
```

### Run QC of resulting assembly
```
CONTIGS=./03-spades/scaffolds.fasta
sbatch step-04-quast.sh ${GENOME} ${ANNOTATION} <sample name> ${CONTIGS} 
```

### Run Ragtag correction
```
sbatch --cpus-per-task=16 step-05-ragtag_correction.sh GCF_000146045.2_R64_genomic.fna GCF_000146045.2_R64_genomic.gff ./03-spades/contigs.fasta readlist.txt
```

### Run Ragtag assembly
```
sbatch --cpus-per-task=16 --time=24:00:00 step-06-ragtag_scaffolds.sh GCF_000146045.2_R64_genomic.fna ./03-spades/contigs.fasta
```

