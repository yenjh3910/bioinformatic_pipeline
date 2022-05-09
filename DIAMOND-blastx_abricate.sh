#!/bin/bash

mkdir ~/MGEs
mkdir ~/ARGs
mkdir ~/abricate

for i in {1..36}
do

#MGEs detection
diamond blastx -d ~/Database/MGEs90.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 50 -p 16 -e 1e-7 -k 1 --query-cover 50 -o ~/MGEs/bin.$i.nucl.uniq.MGEs90.dmnd

#ARG-ARGminer detection
diamond blastx -d ~/Database/ARGminer.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 50 -p 16 -e 1e-7 -k 1 --query-cover 50 -o ~/ARGs/bin.$i.nucl.uniq.ARGminer.dmnd

done

#abricate
abricate --db vfdb --quiet ~/metawrap_run/bin_refinement/metawrap_50_10_bins/bin.*.fa > ~/abricate/VF.table
