mkdir ~/indi_MGE_ORF/index
cd ~/indi_MGE_ORF/index


for i in $(<~/sample_list/sample_type_list)
do

#Build index
bowtie2-build ~/indi_MGE_ORF/${i}_MGE_ORF.fa ${i}_MGE_ORF.index

#Quantification coverage
bowtie2 -x ~/indi_MGE_ORF/index/${i}_MGE_ORF.index -1 ~/clean_read/${i}_1.fastq.gz -2 ~/clean_read/${i}_2.fastq.gz -S ${i}_MGE_ORF.sam -p 16
pileup.sh in=${i}_MGE_ORF.sam out=~/indi_MGE_ORF/${i}_MGE_ORF.sam.map.txt
rm ${i}_MGE_ORF.sam

done
