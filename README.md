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

## metaWRAP (use fastq format except metabat2)
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
mv {final.contigs.fa.metabat-bins-20220508_131755} metabat2_bins
rm ~/metabat2/final.contigs.fa.depth.txt  
mv ~/metabat2/metabat2_bins ~/metawrap_run/initial_binning
```   
### metaWRAP binning (maxbin2, concoct)   
 ```    
 metawrap binning -o ~/metawrap_run/initial_binning -t 16 -a ~/megahit/megehit_coassembly/final.contigs.fa --maxbin2 --concoct ~/clean_read/*fastq    
 ```
### metaWRAP refinement  
```  
metawrap bin_refinement -o ~/metawrap_run/bin_refinement -t 16 -A ~/metawrap_run/initial_binning/metabat2_bins -B ~/metawrap_run/initial_binning/maxbin2_bins -C  ~/metawrap_run/initial_binning/concoct_bins -c 50 -x 10 -m 56 

#If error, maybe re-run concoct binning
metawrap binning -o ~/metawrap_run/initial_binning -t 16 -a ~/megahit/megehit_coassembly/final.contigs.fa --concoct ~/clean_read/*fastq
```  
### metaWRAP quant_bins
```
metawrap quant_bins -b ~/metawrap_run/bin_refinement/metawrap_50_10_bins -o ~/metawrap_run/bin_quant -a ~/megahit/megehit_coassembly/final.contigs.fa ~/clean_read/*fastq -t 16  
conda deactivate
```

## GTBDK

**Usage**   
```   
conda activate gtdbtk-1.5.0   
gtdbtk classify_wf --genome_dir ~/metawrap_run/bin_refinement/metawrap_50_10_bins -x fa --out_dir ~/bins_gtdbdk --scratch_dir scratch.tempory --cpus 16    
conda deactivate
```

## MEGAHIT  
### Individual read assembly  
Clean read name as ${i}_1.fastq.gz & ${i}_2.fastq.gz  
Put all clean read file in $\~/clean_read   
Create list in $\~/sample_list/clean_read_list  
**Usage**  
```  
~/bioinformatic_shell_script/megahit_individual.sh  
```

## ARG_Ranker

**Usage**   
```   
arg_ranker -i arg_ranker_test -kkdb ~/kraken_db -t 16 -o arg_ranker_output   
sh /home/yen/arg_ranker_output/script_output//arg_ranker.sh   
```
