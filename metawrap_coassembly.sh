#!/bin/bash

#metawrap_coassembly
gunzip ~/clean_read/*.gz
cat ~/clean_read/*_1.fastq > ~/clean_read/all_reads_1.fastq
cat ~/clean_read/*_2.fastq > ~/clean_read/all_reads_2.fastq
metawrap assembly -1 ~/clean_read/all_reads_1.fastq -2 ~/clean_read/all_reads_2.fastq -m 56 -t 16 --megahit -o ~/metawrap_coassembly

#quast
~/quast-5.1.0rc1/quast.py ~/metawrap_coassembly/final.contigs.fa -o ~/metawrap_coassembly/coassembly_quast
