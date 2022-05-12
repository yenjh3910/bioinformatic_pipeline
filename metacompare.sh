#!/bin/bash

cd ~/MetaCompare

for i in $(<~/sample_list/clean_read_list)
do
mv ~/megahit/megehit_individual/${i}_assembly/final.contigs.fa ~/megahit/megehit_individual/${i}_assembly/${i}_final.contigs.fa
mv ~/megahit/megehit_individual/${i}_assembly/${i}_final.contigs.fa ~/MetaCompare
./metacmp.py -c ~/megahit/megehit_individual/${i}_assembly/final.contigs.fa -g ~/assembly_prodigal/${i}_assembly.nucl
mv ~/MetaCompare/${i}_final.contigs.fa  ~/megahit/megehit_individual/${i}_assembly

done
