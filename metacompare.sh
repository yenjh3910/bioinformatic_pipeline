#!/bin/bash

cd ~/MetaCompare

for i in $(<~/sample_list/clean_read_list)
do
#rename final contigs & move to ~/metacompare
mv ~/megahit/megehit_individual/${i}_assembly/final.contigs.fa ~/MetaCompare/${i}_final.contigs.fa
#move prodigal nucl to ~/metacompare
mv ~/assembly_prodigal/${i}_assembly.nucl ~/MetaCompare
#run metacompare
./metacmp.py -c ${i}_final.contigs.fa -g ${i}_assembly.nucl
#move file back
mv ~/MetaCompare/${i}_final.contigs.fa  ~/megahit/megehit_individual/${i}_assembly
mv ~/MetaCompare/${i}_assembly.nucl  ~/assembly_prodigal
done
