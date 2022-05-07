#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

cat ~/clean_read/${i}_1.fastq.gz  ~/clean_read/${i}_2.fastq.gz > ~/clean_read/${i}.fastq.gz

#humann
##run
humann -i ~/clean_read/${i}.fastq.gz -o ~/humann --input-format fastq.gz --threads 16

rm ~/clean_read/${i}.fastq.gz

done

##Join the output files
humann_join_tables --input ~/humann --output ~/humann/all_genefamilies.tsv --file_name genefamilies
humann_join_tables --input ~/humann --output ~/humann/all_pathabundance.tsv --file_name pathabundance
humann_join_tables --input ~/humann --output ~/humann/all_pathcoverage.tsv --file_name pathcoverage

##humann_rename_table
humann_rename_table --input ~/humann/all_genefamilies.tsv --names uniref90 --output ~/humann/all_genefamilies_rename_uniref90.tsv

##Renormalization
humann_renorm_table --input ~/humann/all_genefamilies_rename_uniref90.tsv --output ~/humann/all_genefamilies_rename_uniref90_cpm.tsv  --units cpm
humann_renorm_table --input ~/humann/all_genefamilies_rename_uniref90.tsv --output ~/humann/all_genefamilies_rename_uniref90_relab.tsv  --units relab
humann_renorm_table --input ~/humann/all_pathabundance.tsv --output ~/humann/all_pathabundance_cpm.tsv  --units cpm
humann_renorm_table --input ~/humann/all_pathabundance.tsv --output ~/humann/all_pathabundance_relab.tsv  --units relab
