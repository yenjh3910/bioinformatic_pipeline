#!/bin/bash

for i in $(<~/sample_list/clean_read_list)
do

~/KrakenTools-1.2/kreport2mpa.py  -r ~/kraken2_bracken/${i}_kraken2.report  -o ~/kraken2_bracken/${i}_mpa.txt

done

~/KrakenTools-1.2/combine_mpa.py -i ~/kraken2_bracken/*_mpa.txt -o ~/kraken2_bracken/conbined_mpa.txt
