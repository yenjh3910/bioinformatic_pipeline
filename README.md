# Bioinformatic_pipeline

## Kraken
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
Create list in $\~/sample_list/clean_read_list 

**Usage**   
```   
~/bioinformatic_shell_script/kraken2.sh   
```

## DeepARG
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
Create list in $\~/sample_list/clean_read_list

**Usage**   
```   
conda activate deeparg_env    
~/bioinformatic_shell_script/deeparg.sh   
conda deactivate    
```

## ARG-OAP
Clean read name as ${i}_1.fq.gz & ${i}_2.fq.gz  
Create meta-data.txt in $\~/sample_list 

**Usage**   
```   
singularity exec -B ~/clean_read ~/arg-oap/argoapv2.5.sif /home/argsoapv2.5/argoap_version2.5 -i ~/clean_read -m ~/sample_list/meta-data.txt -o ~/arg-oap -n 16  -z   
```

## HUMAnN 3.0   
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
Create list in $\~/sample_list/clean_read_list

**Usage**   
```   
conda activate mpa
~/bioinformatic_shell_script/humann.sh  
conda deactivate
```   
## metaWRAP
### metaWRAP_co-assembly
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
```   
~/bioinformatic_shell_script/metawrap_coassembly.sh   
```   
### metabat2    
```   
cd ~/bowtie2    
bowtie2-build  ~/megahit/S1S3_megehit/S1S3_final.contigs.fa S1S3_contig   
```

## GTBDK

**Usage**

## ARG_Ranker

**Usage**   
```arg_ranker -i arg_ranker_test -kkdb ~/kraken_db -t 16 -o arg_ranker_output```    
```sh /home/yen/arg_ranker_output/script_output//arg_ranker.sh```
