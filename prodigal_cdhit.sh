#!/bin/bash

mkdir ~/prodigal
mkdir ~/cdhit

for i in $(<~/sample_list/bin_list)
do

prodigal -i ~/metawrap_run/bin_refinement/metawrap_50_10_bins/$i -o ~/prodigal/$i.prodigalout -a ~/prodigal/$i.prot -d ~/prodigal/$i.nucl -c -p meta -f gff
cd-hit -i ~/prodigal/$i.nucl -o ~/cdhit/$i.nucl.uniq -M 0 -T 0 -l 250 -s 0.9 -c 0.9
cd-hit -i ~/prodigal/$i.prot -o ~/cdhit/$i.prot.uniq -M 0 -T 0 -l 80 -c 0.9

done
