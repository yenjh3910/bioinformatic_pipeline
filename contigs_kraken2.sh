#!/bin/bash

mkdir ~/contigs_kraken2

for i in $(<~/sample_list/sample_type_list)
do

#kraken2
kraken2 --db ~/Dkraken_db --threads 16 --report ~/contigs_kraken2/${i}_contigs_kraken2.report --output ~/contigs_kraken2/${i}_contigs_kraken2.output ~/megahit/megehit_individual/${i}_assembly/${i}_final.contigs.fa --use-names

done
