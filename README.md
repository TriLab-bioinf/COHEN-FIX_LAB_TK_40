# COHEN-FIX_LAB_TK_40

### Generate QC reports for fastq files
```
sbatch step-01-fastqc.sh <path to raw reads directory> <sample name>
```

### Remove adapters and trim reads based on sequencing quality values
```
sbatch step-02-trim_reads.sh <path to raw reads directory> <sample name> <adapter fasta file>
```

### Perform assembly with "spades"
```
sbatch step-03-spades_assembly.sh <path to trimmed reads directory> <sample name>
```

### Run QC of resulting assembly
```
CONTIGS=./03-spades/scaffolds.fasta
sbatch step-04-quast.sh ${GENOME} ${ANNOTATION} <sample name> ${CONTIGS} 


