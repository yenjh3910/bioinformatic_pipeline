#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

seqkit seq ~/assembly_prodigal/${i}_assembly.nucl -m 1000 -o ~/assembly_prodigal/${i}_assembly_1000.fasta

done
