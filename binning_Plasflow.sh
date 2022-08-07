#!/bin/bash

mkdir ~/Binning_PlasFlow

PlasFlow.py --input ~/megahit_coassembly/final.contigs.fa --output ~/Binning_PlasFlow/coassembly.plasflow_predictions.tsv --threshold 0.7
