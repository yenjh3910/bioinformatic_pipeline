#!/bin/bash

#metawrap_coassembly
gunzip ~/clean_read/*.gz
rm ~/clean_read/*.fastq
cat ~/clean_read/*_1.fastq > ~/clean_read/all_reads_1.fastq
cat ~/clean_read/*_2.fastq > ~/clean_read/all_reads_2.fastq
metawrap assembly -1 ~/clean_read/all_reads_1.fastq -2 ~/clean_read/all_reads_2.fastq -m 56 -t 16 --megahit -o ~/metawrap_coassembly

#quast
quast.py ~/metawrap_coassembly/final.contigs.fa -o coassembly_quast
