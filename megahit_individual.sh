#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

megahit -t 16 -m 0.95 -1 ~/clean_read/${i}_1.fastq.gz -2 ~/clean_read/${i}_2.fastq.gz --min-contig-len 1000 -o ~/megahit/megehit_individual

done
