#!/bin/bash

#binning
metawrap binning -o initial_binning -t 16 -a ~/megahit/S1S3_megehit/S1S3_final.contigs.fa --maxbin2 --concoct *fastq

#refinement
metawrap bin_refinement -o S1S3_bin_refinement -t 16 -A metabat2_bins -B maxbin2_bins -C  concoct_bins -c 50 -x 5 -m 0.95

#Quant_bins
