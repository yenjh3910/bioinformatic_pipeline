#!/bin/bash

cd ~/bowtie2

for i in {1..36}

do
        seqkit subseq --gtf ~/ARG_MGE_manually_gtf/bin.${i}.nucl.uniq.ARGminer.dmnd.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/ARGs/bin.${i}.gtf.gene.fasta #the gtf file was prepared manually
        bowtie2-build ~/ARGs/bin.${i}.gtf.gene.fasta bin.${i}.bt2.index
        bowtie2 -x ~/bowtie2/bin.${i}.bt2.index -1 ~/clean_read/S1S3_reads_1.fastq -2 ~/data_download/S1S3_reads_2.fastq -S bin.${i}.S1S3.sam -p 16
        pileup.sh in=bin.${i}.S1S3.sam out=bin.${i}.S1S3.sam.map.txt
        rm bin.${i}.S1S3.sam
done
