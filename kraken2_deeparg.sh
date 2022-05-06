#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

#kraken2 + bracken + korna
kraken2 --db ~/kraken_db --threads 16 --report ~/kraken2_bracken/${i}_kraken2.report --output ~/kraken2_bracken/${i}_kraken2.output --paired ~/clean_read/${i}_1.fastq.gz ~/clean_read/${i}_2.fastq.gz

bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.D.bracken -w ${i}.D.bracken.report -r 150 -l D
bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.P.bracken -w ${i}.P.bracken.report -r 150 -l P
bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.C.bracken -w ${i}.C.bracken.report -r 150 -l C
bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.O.bracken -w ${i}.O.bracken.report -r 150 -l O
bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.F.bracken -w ${i}.F.bracken.report -r 150 -l F
bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.G.bracken -w ${i}.G.bracken.report -r 150 -l G
bracken -d ~/kraken_db -i ${i}_kraken2.report -o ${i}.S.bracken -w ${i}.S.bracken.report -r 150 -l S

ktImportTaxonomy -q 2 -t 3 ~/kraken2_bracken/${i}_kraken2.output -o ${i}_krona

#deeparg
conda activate deeparg_env
deeparg short_reads_pipeline --forward_pe_file ~/clean_read/${i}_1.fastq.gz --reverse_pe_file ~/clean_read/${i}_2.fastq.gz --output_file ~/deeparg/${i}_deeparg -d ~/deeparg_download --bowtie_16s_identity 0.85
source deactivate

done
