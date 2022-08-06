#!/bin/bash

mkdir ~/Binning_PlasFlow
mkdir ~/Binning_PlasFlow/SARG
mkdir ~/Binning_PlasFlow/MGE
mkdir ~/Binning_PlasFlow/MRG

for i in {1..129}
do

#SARG
PlasFlow.py --input ~/manual_gtf_2.0/SARG_bt_index_gene/bin.${i}.SARG.fasta --output ~/Binning_PlasFlow/SARG/bin.${i}.SARG.plasflow_predictions.tsv --threshold 0.7

#MGE
PlasFlow.py --input ~/manual_gtf_2.0/MGE_bt_index_gene/bin.${i}.MGE.fasta --output ~/Binning_PlasFlow/MGE/bin.${i}.MGE.plasflow_predictions.tsv --threshold 0.7

#MRG
PlasFlow.py --input ~/manual_gtf_2.0/MRG_bt_index_gene/bin.${i}.MRG.fasta --output ~/Binning_PlasFlow/MRG/bin.${i}.MRG.plasflow_predictions.tsv --threshold 0.7

done
