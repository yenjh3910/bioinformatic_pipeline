#!/bin/bash

mkdir ~/cdhit_individual_assembly

mkdir ~/individual_assembly_diamond
mkdir ~/individual_assembly_diamond/SARG
mkdir ~/individual_assembly_diamond/MGE
mkdir ~/individual_assembly_diamond/MRG

for i in $(<~/sample_list/clean_read_list)
do

##CDHIT
cd-hit -i ~/assembly_prodigal/${i}_assembly.nucl -o ~/cdhit_individual_assembly/${i}.nucl.uniq -M 0 -T 0 -l 250 -s 0.9 -c 0.9
cd-hit -i ~/assembly_prodigal/${i}_assembly.prot -o ~/cdhit_individual_assembly/${i}.prot.uniq -M 0 -T 0 -l 80 -c 0.9

#SARG detection
diamond blastx -d ~/Database/arg-oap/SARG_manual.dmnd -q ~/cdhit_individual_assembly/${i}.nucl.uniq --id 70 -p 16 -e 1e-10 -k 1 --query-cover 70 -o ~/individual_assembly_diamond/SARG/${i}_assembly.nucl.SARG.dmnd

#MGE detection
diamond blastx -d ~/Database/MGEs_database_amino.dmnd -q ~/cdhit_individual_assembly/${i}.nucl.uniq --id 70 -p 16 -e 1e-10 -k 1 --query-cover 70 -o ~/individual_assembly_diamond/MGE/${i}_assembly.nucl.MGE.dmnd

#MRG detection
diamond blastx -d ~/Database/BacMet2_EXP.dmnd -q ~/cdhit_individual_assembly/${i}.nucl.uniq --id 70 -p 16 -e 1e-10 -k 1 --query-cover 70 -o ~/individual_assembly_diamond/MRG/${i}_assembly.nucl.MRG.dmnd

done
