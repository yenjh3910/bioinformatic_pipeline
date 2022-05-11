#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

#prodigal
mkdir ~/assembly_prodigal
prodigal -i ~/megahit/megehit_individual/${i}_assembly/final.contigs.fa -o ~/assembly_prodigal/${i}_assembly.prodigalout -a ~/assembly_prodigal/${i}_assembly.prot -d ~/assembly_prodigal/${i}_assembly.nucl -c -p meta

#ARG-ARGminer detection
mkdir ~/individual_assembly_arg
diamond blastx -d ~/Database/ARGminer.dmnd -q ~/assembly_prodigal/prodigal/${i}_assembly.nucl --id 50 -p 16 -e 1e-7 -k 1 --query-cover 50 -o ~/individual_assembly_arg/{i}_assembly.nucl.ARGminer.dmnd

done
