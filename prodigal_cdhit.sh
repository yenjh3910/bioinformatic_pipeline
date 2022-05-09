#!/bin/bash

mkdir ~/prodigal
mkdir ~/cdhit

for i in $(<~/sample_list/bin_list)
do

prodigal -i ~/metawrap_run/bin_refinement/metawrap_50_10_bins/bin.${i}.fa -o ~/prodigal/bin.${i}.prodigalout -a ~/prodigal/bin.${i}.prot -d ~/prodigal/bin.${i}.nucl -c -p meta -f gff
cd-hit -i ~/prodigal/bin.${i}.nucl -o ~/cdhit/bin.${i}.nucl.uniq -M 0 -T 0 -l 250 -s 0.9 -c 0.9
cd-hit -i ~/prodigal/bin.${i}.prot -o ~/cdhit/bin.${i}.prot.uniq -M 0 -T 0 -l 80 -c 0.9

done
