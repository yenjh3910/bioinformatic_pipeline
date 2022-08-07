#!/bin/bash

mkdir ~/individual_assembly_plasflow

for i in $(<~/sample_list/sample_type_list)
do

#Plasflow
PlasFlow.py --input ~/megahit/megehit_individual/${i}_assembly/${i}_final.contigs.fa --output ~/individual_assembly_plasflow/${i}.plasflow_predictions.tsv --threshold 0.7

done
