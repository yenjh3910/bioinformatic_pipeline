#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

#argoap
singularity exec -B ~/clean_read ~/arg-oap/argoapv2.5.sif /home/argsoapv2.5/argoap_version2.5 -i ~/clean_read -m ~/sample_list/meta-data.txt -o ~/arg-oap -n 16  -z

done
