#!/bin/bash

cd ~/bowtie2
mkdir ~/gene_coverage
mkdir ~/gene_coverage/arg_vfarb
mkdir ~/gene_coverage/arg_arb
mkdir ~/gene_coverage/mge_vfarb
mkdir ~/gene_coverage/mge_arb

for i in {1..129}
do

#Build index
#the gtf file was prepared manually

##arg in vfarb
seqkit subseq --gtf ~/ARG_MGE_manually_gtf/ARG_in_VFARB/bin.${i}.nucl.uniq.ARGminer.dmnd.vfarb.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/ARGs/bin.${i}.arg.vfarb.gtf.gene.fasta
bowtie2-build ~/ARGs/bin.${i}.arg.vfarb.gtf.gene.fasta bin.${i}.arg.vfarb.bt2.index

##arg in arb
seqkit subseq --gtf ~/ARG_MGE_manually_gtf/ARG_in_ARB/bin.${i}.nucl.uniq.ARGminer.dmnd.arb.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/ARGs/bin.${i}.arg.arb.gtf.gene.fasta
bowtie2-build ~/ARGs/bin.${i}.arg.arb.gtf.gene.fasta bin.${i}.arg.arb.bt2.index

##mge in vfarb
seqkit subseq --gtf ~/ARG_MGE_manually_gtf/MGE_in_VFARB/bin.${i}.nucl.uniq.MGEs90.dmnd.vfarb.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/MGEs/bin.${i}.mge.vfarb.gtf.gene.fasta
bowtie2-build ~/MGEs/bin.${i}.mge.vfarb.gtf.gene.fasta bin.${i}.mge.vfarb.bt2.index

##mge in arb
seqkit subseq --gtf ~/ARG_MGE_manually_gtf/MGE_in_ARB/bin.${i}.nucl.uniq.MGEs90.dmnd.arb.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/MGEs/bin.${i}.mge.arb.gtf.gene.fasta
bowtie2-build ~/MGEs/bin.${i}.mge.arb.gtf.gene.fasta bin.${i}.mge.arb.bt2.index

#Quantification coverage

for j in $(<~/sample_list/sample_type_list)
do

##arg in vfarb
bowtie2 -x ~/bowtie2/bin.${i}.arg.vfarb.bt2.index -1 ~/clean_read/${j}_1.fastq -2 ~/clean_read/${j}_2.fastq -S ${j}.bin.${i}.arg.vfarb.sam -p 16
pileup.sh in=${j}.bin.${i}.arg.vfarb.sam out=~/gene_coverage/arg_vfarb/${j}.bin.${i}.arg.vfarb.sam.map.txt
rm ${j}.bin.${i}.arg.vfarb.sam

##arg in arb
bowtie2 -x ~/bowtie2/bin.${i}.arg.arb.bt2.index -1 ~/clean_read/${j}_1.fastq -2 ~/clean_read/${j}_2.fastq -S ${j}.bin.${i}.arg.arb.sam -p 16
pileup.sh in=${j}.bin.${i}.arg.arb.sam out=~/gene_coverage/arg_arb/${j}.bin.${i}.arg.arb.sam.map.txt
rm ${j}.bin.${i}.arg.arb.sam

##mge in vfarb
bowtie2 -x ~/bowtie2/bin.${i}.mge.vfarb.bt2.index -1 ~/clean_read/${j}_1.fastq -2 ~/clean_read/${j}_2.fastq -S ${j}.bin.${i}.mge.vfarb.sam -p 16
pileup.sh in=${j}.bin.${i}.mge.vfarb.sam out=~/gene_coverage/mge_vfarb/${j}.bin.${i}.mge.vfarb.sam.map.txt
rm ${j}.bin.${i}.mge.vfarb.sam

##mge in arb
bowtie2 -x ~/bowtie2/bin.${i}.mge.arb.bt2.index -1 ~/clean_read/${j}_1.fastq -2 ~/clean_read/${j}_2.fastq -S ${j}.bin.${i}.mge.arb.sam -p 16
pileup.sh in=${j}.bin.${i}.mge.arb.sam out=~/gene_coverage/mge_arb/${j}.bin.${i}.mge.arb.sam.map.txt
rm ${j}.bin.${i}.mge.arb.sam

done

done
