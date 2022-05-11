#!/bin/bash

mkdir ~/PlasFlow

for i in $(<~/sample_list/clean_read_list)
do

PlasFlow.py --input ~/assembly_prodigal/${i}_assembly_1000.fasta --output ~/PlasFlow/${i}.plasflow_predictions.tsv --threshold 0.7

done
