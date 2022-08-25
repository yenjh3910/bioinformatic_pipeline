cd ~/crassphage

for i in $(<~/sample_list/sample_type_list)
do

#Quantification coverage
bowtie2 -x ~/crassphage/crassphage.index -1 ~/clean_read/${i}_1.fastq.gz -2 ~/clean_read/${i}_2.fastq.gz -S ${i}_crassphage.sam -p 16
pileup.sh in=${i}_crassphage.sam out=~/crassphage/${i}_crassphage.sam.map.txt
rm ${i}_crassphage.sam

done
