#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

PlasFlow.py --input ~/assembly_prodigal/${i}_assembly_1000.fasta --output {i}.plasflow_predictions.tsv --threshold 0.7

done
