#!/bin/bash

mkdir ~/ARGs_SARG
mkdir ~/MGEs_2.0
mkdir ~/VFs_2.0

for i in {1..129}
do

#ARG-SARG detection
diamond blastx -d ~/Database/arg-oap/SARG.fasta.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 80 -p 16 -e 1e-10 -k 1 --query-cover 70 -o ~/ARGs_SARG/bin.$i.nucl.uniq.SARG.dmnd

#MGE detection
diamond blastx -d ~/Database/MGEs_database_amino.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 80 -p 16 -e 1e-10 -k 1 --query-cover 70 -o ~/MGEs_2.0/bin.$i.nucl.uniq.MGEv2.dmnd

#VF detection
diamond blastx -d ~/Database/vf.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 80 -p 16 -e 1e-10 -k 1 --query-cover 70 -o ~/VFs_2.0/bin.$i.nucl.uniq.vf.dmnd

done
