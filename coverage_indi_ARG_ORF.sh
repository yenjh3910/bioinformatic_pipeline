mkdir ~/indi_ARG_ORF/index
cd ~/indi_ARG_ORF/index


for i in $(<~/sample_list/sample_type_list)
do

#Build index
bowtie2-build ~/indi_ARG_ORF/${i}_ARG_ORF.fa ${i}_ARG_ORF.index

#Quantification coverage
bowtie2 -x ~/indi_ARG_ORF/index/${i}_ARG_ORF.index -1 ~/clean_read/${i}_1.fastq.gz -2 ~/clean_read/${i}_2.fastq.gz -S ${i}_ARG_ORF.sam -p 16
pileup.sh in=${i}_ARG_ORF.sam out=~/indi_ARG_ORF/${i}_ARG_ORF.sam.map.txt
rm ${i}_ARG_ORF.sam

done
