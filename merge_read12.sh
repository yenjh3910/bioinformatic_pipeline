#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

cat ~/clean_read/${i}_1.fastq ~/clean_read/${i}_2.fastq > ~/clean_read/${i}.fastq
rm ~/clean_read/${i}_1.fastq ~/clean_read/${i}_2.fastq

done
