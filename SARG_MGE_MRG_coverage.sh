#!/bin/bash

cd ~/bowtie2
mkdir ~/gene_coverage_2.0
mkdir ~/gene_coverage_2.0/SARG_map
mkdir ~/gene_coverage_2.0/MGE_map
mkdir ~/gene_coverage_2.0/MRG_map

for i in {1..129}
do

#Build index
#the gtf file was prepared manually

##SARG
seqkit subseq --gtf ~/manual_gtf_2.0/SARG/bin.${i}.gtf.SARG.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/manual_gtf_2.0/SARG_bt_index_gene/bin.${i}.SARG.fasta
bowtie2-build ~/manual_gtf_2.0/SARG_bt_index_gene/bin.${i}.SARG.fasta bin.${i}.SARG.bt2.index

##MGE
seqkit subseq --gtf ~/manual_gtf_2.0/MGE/bin.${i}.gtf.MGE.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/manual_gtf_2.0/MGE_bt_index_gene/bin.${i}.MGE.fasta
bowtie2-build ~/manual_gtf_2.0/MGE_bt_index_gene/bin.${i}.MGE.fasta bin.${i}.MGE.bt2.index

##MRG
seqkit subseq --gtf ~/manual_gtf_2.0/MRG/bin.${i}.gtf.MRG.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/manual_gtf_2.0/MRG_bt_index_gene/bin.${i}.MRG.fasta
bowtie2-build ~/manual_gtf_2.0/MRG_bt_index_gene/bin.${i}.MRG.fasta bin.${i}.MRG.bt2.index

#Quantification coverage

for j in $(<~/sample_list/sample_type_list)
do

##SARG
bowtie2 -x ~/bowtie2/bin.${i}.SARG.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.SARG.sam -p 16
pileup.sh in=${j}.bin.${i}.SARG.sam out=~/gene_coverage_2.0/SARG_map/${j}.bin.${i}.SARG.sam.map.txt
rm ${j}.bin.${i}.SARG.sam

#MGE
bowtie2 -x ~/bowtie2/bin.${i}.MGE.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.MGE.sam -p 16
pileup.sh in=${j}.bin.${i}.MGE.sam out=~/gene_coverage_2.0/MGE_map/${j}.bin.${i}.MGE.sam.map.txt
rm ${j}.bin.${i}.MGE.sam

#MRG
bowtie2 -x ~/bowtie2/bin.${i}.MRG.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.MRG.sam -p 16
pileup.sh in=${j}.bin.${i}.MRG.sam out=~/gene_coverage_2.0/MRG_map/${j}.bin.${i}.MRG.sam.map.txt
rm ${j}.bin.${i}.MRG.sam

done

done
