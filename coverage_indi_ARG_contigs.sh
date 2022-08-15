mkdir ~/indi_ARG_contigs/index
cd ~/indi_ARG_contigs/index


for i in $(<~/sample_list/sample_type_list)
do

#Build index
bowtie2-build ~/indi_ARG_contigs/${i}.ARG_contigs.fa ${i}.ARG_contigs.index

#Quantification coverage
bowtie2 -x ~/indi_ARG_contigs/index/${i}.ARG_contigs.index -1 ~/clean_read/${i}_1.fastq.gz -2 ~/clean_read/${i}_2.fastq.gz -S ${i}_ARG_contigs.sam -p 16
pileup.sh in=${i}_ARG_contigs.sam out=~/indi_ARG_contigs/${i}_ARG_contigs.sam.map.txt
rm ${i}_ARG_contigs.sam

done
