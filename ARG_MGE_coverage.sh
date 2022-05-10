#!/bin/bash

cd ~/bowtie2
mkdir ~/gene_coverage
mkdir ~/gene_coverage/arg_vf
mkdir ~/gene_coverage/arg_novf
mkdir ~/gene_coverage/mge_vf
mkdir ~/gene_coverage/mge_novf

#ARGs with VFs
for i in {1..36}
do
        seqkit subseq --gtf ~/ARG_MGE_manually_gtf/bin.${i}.nucl.uniq.ARGminer.dmnd.vf.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/ARGs/bin.${i}.arg.vf.gtf.gene.fasta #the gtf file was prepared manually
        bowtie2-build ~/ARGs/bin.${i}.arg.vf.gtf.gene.fasta bin.${i}.arg.vf.bt2.index
        
        bowtie2 -x ~/bowtie2/bin.${i}.arg.vf.bt2.index -1 ~/clean_read/{type1}_1.fastq -2 ~/clean_read/{type1}_2.fastq -S bin.${i}.arg.vf.{type1}.sam -p 16
        pileup.sh in=bin.${i}.arg.vf.{type1}.sam out=~/gene_coverage/arg_vf/bin.${i}.arg.vf.{type1}.sam.map.txt
        rm bin.${i}.arg.vf.{type1}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.arg.vf.bt2.index -1 ~/clean_read/{type2}_1.fastq -2 ~/clean_read/{type2}_2.fastq -S bin.${i}.arg.vf.{type2}.sam -p 16
        pileup.sh in=bin.${i}.arg.vf.{type2}.sam out=~/gene_coverage/arg_vf/bin.${i}.arg.vf.{type2}.sam.map.txt
        rm bin.${i}.arg.vf.{type2}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.arg.vf.bt2.index -1 ~/clean_read/{type3}_1.fastq -2 ~/clean_read/{type3}_2.fastq -S bin.${i}.arg.vf.{type3}.sam -p 16
        pileup.sh in=bin.${i}.arg.vf.{type3}.sam out=~/gene_coverage/arg_vf/bin.${i}.arg.vf.{type3}.sam.map.txt
        rm bin.${i}.arg.vf.{type3}.sam
done

#ARGs without VFs
for i in {1..36}
do
        seqkit subseq --gtf ~/ARG_MGE_manually_gtf/bin.${i}.nucl.uniq.ARGminer.dmnd.novf.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/ARGs/bin.${i}.arg.novf.gtf.gene.fasta #the gtf file was prepared manually
        bowtie2-build ~/ARGs/bin.${i}.arg.novf.gtf.gene.fasta bin.${i}.arg.novf.bt2.index
        
        bowtie2 -x ~/bowtie2/bin.${i}.arg.novf.bt2.index -1 ~/clean_read/{type1}_1.fastq -2 ~/clean_read/{type1}_2.fastq -S bin.${i}.arg.novf.{type1}.sam -p 16
        pileup.sh in=bin.${i}.arg.novf.{type1}.sam out=~/gene_coverage/arg_novf/bin.${i}.arg.novf.{type1}.sam.map.txt
        rm bin.${i}.arg.novf.{type1}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.arg.novf.bt2.index -1 ~/clean_read/{type2}_1.fastq -2 ~/clean_read/{type2}_2.fastq -S bin.${i}.arg.novf.{type2}.sam -p 16
        pileup.sh in=bin.${i}.arg.novf.{type2}.sam out=~/gene_coverage/arg_novf/bin.${i}.arg.novf.{type2}.sam.map.txt
        rm bin.${i}.arg.novf.{type2}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.arg.novf.bt2.index -1 ~/clean_read/{type3}_1.fastq -2 ~/clean_read/{type3}_2.fastq -S bin.${i}.arg.novf.{type3}.sam -p 16
        pileup.sh in=bin.${i}.arg.novf.{type3}.sam out=~/gene_coverage/arg_vf/bin.${i}.arg.novf.{type3}.sam.map.txt
        rm bin.${i}.arg.novf.{type3}.sam
done

#MGEs with VFs
for i in {1..36}
do
        seqkit subseq --gtf ~/ARG_MGE_manually_gtf/bin.${i}.nucl.uniq.MGE.dmnd.vf.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/MGEs/bin.${i}.mge.vf.gtf.gene.fasta #the gtf file was prepared manually
        bowtie2-build ~/MGEss/bin.${i}.mge.vf.gtf.gene.fasta bin.${i}.mge.vf.bt2.index
        
        bowtie2 -x ~/bowtie2/bin.${i}.mge.vf.bt2.index -1 ~/clean_read/{type1}_1.fastq -2 ~/clean_read/{type1}_2.fastq -S bin.${i}.mge.vf.{type1}.sam -p 16
        pileup.sh in=bin.${i}.mge.vf.{type1}.sam out=~/gene_coverage/mge_vf/bin.${i}.mge.vf.{type1}.sam.map.txt
        rm bin.${i}.mge.vf.{type1}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.mge.vf.bt2.index -1 ~/clean_read/{type2}_1.fastq -2 ~/clean_read/{type2}_2.fastq -S bin.${i}.mge.vf.{type2}.sam -p 16
        pileup.sh in=bin.${i}.mge.vf.{type2}.sam out=~/gene_coverage/mge_vf/bin.${i}.mge.vf.{type2}.sam.map.txt
        rm bin.${i}.mge.vf.{type2}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.mge.vf.bt2.index -1 ~/clean_read/{type3}_1.fastq -2 ~/clean_read/{type3}_2.fastq -S bin.${i}.mge.vf.{type3}.sam -p 16
        pileup.sh in=bin.${i}.mge.vf.{type3}.sam out=~/gene_coverage/mge_vf/bin.${i}.mge.vf.{type3}.sam.map.txt
        rm bin.${i}.mge.vf.{type3}.sam
done

#ARGs without VFs
for i in {1..36}
do
        seqkit subseq --gtf ~/ARG_MGE_manually_gtf/bin.${i}.nucl.uniq.MGE.dmnd.novf.gtf.txt ~/cdhit/bin.${i}.nucl.uniq -o ~/MGEs/bin.${i}.mge.novf.gtf.gene.fasta #the gtf file was prepared manually
        bowtie2-build ~/MGEs/bin.${i}.mge.novf.gtf.gene.fasta bin.${i}.mge.novf.bt2.index
        
        bowtie2 -x ~/bowtie2/bin.${i}.mge.novf.bt2.index -1 ~/clean_read/{type1}_1.fastq -2 ~/clean_read/{type1}_2.fastq -S bin.${i}.mge.novf.{type1}.sam -p 16
        pileup.sh in=bin.${i}.mge.novf.{type1}.sam out=~/gene_coverage/mge_novf/bin.${i}.mge.novf.{type1}.sam.map.txt
        rm bin.${i}.mge.novf.{type1}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.mge.novf.bt2.index -1 ~/clean_read/{type2}_1.fastq -2 ~/clean_read/{type2}_2.fastq -S bin.${i}.mge.novf.{type2}.sam -p 16
        pileup.sh in=bin.${i}.mge.novf.{type2}.sam out=~/gene_coverage/mge_novf/bin.${i}.mge.novf.{type2}.sam.map.txt
        rm bin.${i}.mge.novf.{type2}.sam
        
        bowtie2 -x ~/bowtie2/bin.${i}.mge.novf.bt2.index -1 ~/clean_read/{type3}_1.fastq -2 ~/clean_read/{type3}_2.fastq -S bin.${i}.mge.novf.{type3}.sam -p 16
        pileup.sh in=bin.${i}.mge.novf.{type3}.sam out=~/gene_coverage/mge_novf/bin.${i}.mge.novf.{type3}.sam.map.txt
        rm bin.${i}.mge.novf.{type3}.sam
done
