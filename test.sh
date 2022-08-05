#!/bin/bash

cd ~/bowtie2
mkdir ~/gene_coverage_2.0/MRG_map

for i in {1..16}
do

#Build index
#the gtf file was prepared manually

##MRG
seqkit subseq --gtf ~/manual_gtf_2.0/MRG/bin.${i}.gtf.MRG.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/manual_gtf_2.0/MRG_bt_index_gene/bin.${i}.MRG.fasta
bowtie2-build ~/manual_gtf_2.0/MRG_bt_index_gene/bin.${i}.MRG.fasta bin.${i}.MRG.bt2.index

#Quantification coverage

for j in $(<~/sample_list/sample_type_list)
do

#MRG
bowtie2 -x ~/bowtie2/bin.${i}.MRG.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.MRG.sam -p 16
pileup.sh in=${j}.bin.${i}.MRG.sam out=~/gene_coverage_2.0/MRG_map/${j}.bin.${i}.MRG.sam.map.txt
rm ${j}.bin.${i}.MRG.sam

done

done
