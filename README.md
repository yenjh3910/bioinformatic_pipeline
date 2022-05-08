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
## MEGAHIT
### co-assembly
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
```  
#metawrap_coassembly
gunzip ~/clean_read/*.gz
cat ~/clean_read/*_1.fastq > ~/clean_read/all_reads_1.fastq
cat ~/clean_read/*_2.fastq > ~/clean_read/all_reads_2.fastq
megahit -t 16 -m 0.95 -1 ~/clean_read/all_reads_1.fastq -2 ~/clean_read/all_reads_2.fastq --min-contig-len 1000 -o ~/megahit/megehit_coassembly   
rm ~/clean_read/all_reads_1.fastq ~/clean_read/all_reads_2.fastq

#quast
~/quast-5.1.0rc1/quast.py ~/megahit/megehit_coassembly/final.contigs.fa -o ~/megahit/megehit_coassembly/coassembly_quast
```   

## metaWRAP
### metabat2    
```   
cd ~/bowtie2    
bowtie2-build  ~/megahit/megehit_coassembly/final.contigs.fa coassembly_contig   
```   
copy clean reads to $bowtie2    
```   
bowtie2 -x coassembly_contig -1 {read1_1.fastq.gz,read2_1.fastq.gz,...} -2  {read1_2.fastq.gz,read2_2.fastq.gz,...} | samtools sort -o coassembly.sort.bam  
```
delete clean reads in $bowtie2    
```
conda activate metawrap-env
cd ~/metabat2
runMetaBat.sh ~/megahit/megehit_coassembly/final.contigs.fa ~/bowtie2/coassembly.sort.bam
```
## GTBDK

**Usage**   
```   
conda activate gtdbtk-1.5.0   

gtdbtk classify_wf --genome_dir ~/metaWRAP_run/S1S3_initial_binning/S1S3_bin_refinement/metawrap_50_5_bins -x fa --out_dir S1S3_gtdbdk --scratch_dir scratch.tempory --cpus 16    

conda deactivate
```

## ARG_Ranker

**Usage**   
```   
arg_ranker -i arg_ranker_test -kkdb ~/kraken_db -t 16 -o arg_ranker_output   
sh /home/yen/arg_ranker_output/script_output//arg_ranker.sh   
```
