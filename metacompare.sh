#!/bin/bash

cd ~/MetaCompare

for i in $(<~/sample_list/clean_read_list)
do

./metacmp.py -c ~/megahit/megehit_individual/${i}_assembly/final.contigs.fa -g ~/assembly_prodigal/${i}_assembly.nucl

done
