#!/bin/bash

cd ~/bowtie2
mkdir ~/gene_coverage_2.0

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

##VF
seqkit subseq --gtf ~/manual_gtf_2.0/VF/bin.${i}.gtf.VF.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/manual_gtf_2.0/VF_bt_index_gene/bin.${i}.VF.fasta
bowtie2-build ~/manual_gtf_2.0/VF_bt_index_gene/bin.${i}.VF.fasta bin.${i}.VF.bt2.index

#Quantification coverage

for j in $(<~/sample_list/sample_type_list)
do

##SARG
bowtie2 -x ~/bowtie2/bin.${i}.SARG.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.SARG.sam -p 16
pileup.sh in=${j}.bin.${i}.SARG.sam out=~/gene_coverage_2.0/${j}.bin.${i}.SARG.sam.map.txt
rm ${j}.bin.${i}.SARG.sam

#MGE
bowtie2 -x ~/bowtie2/bin.${i}.MGE.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.MGE.sam -p 16
pileup.sh in=${j}.bin.${i}.MGE.sam out=~/gene_coverage_2.0/${j}.bin.${i}.MGE.sam.map.txt
rm ${j}.bin.${i}.MGE.sam

#VF
bowtie2 -x ~/bowtie2/bin.${i}.VF.bt2.index -1 ~/clean_read/${j}_1.fastq.gz -2 ~/clean_read/${j}_2.fastq.gz -S ${j}.bin.${i}.VF.sam -p 16
pileup.sh in=${j}.bin.${i}.VF.sam out=~/gene_coverage_2.0/${j}.bin.${i}.VF.sam.map.txt
rm ${j}.bin.${i}.VF.sam

done

done
