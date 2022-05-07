#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

#deeparg
deeparg short_reads_pipeline --forward_pe_file ~/clean_read/${i}_1.fastq.gz --reverse_pe_file ~/clean_read/${i}_2.fastq.gz --output_file ~/deeparg/${i}_deeparg -d ~/deeparg_download --bowtie_16s_identity 0.85
rm *paired
rm *merged

done
