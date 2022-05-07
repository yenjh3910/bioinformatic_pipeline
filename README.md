# Bioinformatic_pipeline

## Kraken
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
Create list in $\~/sample_list/clean_read_list 

**Usage**   
```~/bioinformatic_shell_script/kraken2.sh``` 

## DeepARG
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
Create list in $\~/sample_list/clean_read_list

**Usage**   
```conda activate deeparg_env```    
```~/bioinformatic_shell_script/deeparg.sh```   
```source deactivate```

## ARG-OAP
Clean read name as ${i}_1.fq.gz & ${i}_2.fq.gz  
Create meta-data.txt in $\~/sample_list 

**Usage**   
```singularity exec -B ~/clean_read ~/arg-oap/argoapv2.5.sif /home/argsoapv2.5/argoap_version2.5 -i ~/clean_read -m ~/sample_list/meta-data.txt -o ~/arg-oap -n 16  -z```
