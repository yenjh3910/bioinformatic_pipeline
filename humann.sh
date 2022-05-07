#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

cat ~/clean_read/_1.fastq.gz  ~/clean_read/S1_clean_R2.fastq.gz > merge_S1.fastq.gz
