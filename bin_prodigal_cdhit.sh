#!/bin/bash

mkdir ~/prodigal
mkdir ~/cdhit

for i in {1..36}
do

prodigal -i ~/metawrap_run/bin_refinement/metawrap_50_10_bins/bin.$i.fa -o ~/prodigal/bin.$i.gff -a ~/prodigal/bin.$i.prot -d ~/prodigal/bin.$i.nucl -c -p meta -f gff
gffread ~/prodigal/bin.$i.gff -T -o ~/prodigal/bin.$i.gtf
cd-hit -i ~/prodigal/bin.$i.nucl -o ~/cdhit/bin.$i.nucl.uniq -M 0 -T 0 -l 250 -s 0.9 -c 0.9
cd-hit -i ~/prodigal/bin.$i.prot -o ~/cdhit/bin.$i.prot.uniq -M 0 -T 0 -l 80 -c 0.9

done
