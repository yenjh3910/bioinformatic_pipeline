#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

#kraken2 + bracken + korna
kraken2 --db ~/kraken_db --threads 16 --report ~/kraken2_bracken/${i}_kraken2.report --output ~/kraken2_bracken/${i}_kraken2.output --paired ~/clean_read/${i}_1.fastq.gz ~/clean_read/${i}_2.fastq.gz

bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.D.bracken -w ~/kraken2_bracken/${i}.D.bracken.report -r 150 -l D
bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.P.bracken -w ~/kraken2_bracken/${i}.P.bracken.report -r 150 -l P
bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.C.bracken -w ~/kraken2_bracken/${i}.C.bracken.report -r 150 -l C
bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.O.bracken -w ~/kraken2_bracken/${i}.O.bracken.report -r 150 -l O
bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.F.bracken -w ~/kraken2_bracken/${i}.F.bracken.report -r 150 -l F
bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.G.bracken -w ~/kraken2_bracken/${i}.G.bracken.report -r 150 -l G
bracken -d ~/kraken_db -i ~/kraken2_bracken/${i}_kraken2.report -o ~/kraken2_bracken/${i}.S.bracken -w ~/kraken2_bracken/${i}.S.bracken.report -r 150 -l S

done
