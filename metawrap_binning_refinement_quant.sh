#!/bin/bash

#binning
metawrap binning -o ~/metawrap_run/initial_binning -t 16 -a ~/megahit/megehit_coassembly/final.contigs.fa --maxbin2 --concoct *fastq

#refinement
metawrap bin_refinement -o ~/metawrap_run/bin_refinement -t 16 -A metabat2_bins -B maxbin2_bins -C  concoct_bins -c 50 -x 10 -m 0.95

#Quant_bins
metawrap quant_bins -b ~/metawrap_run/bin_refinement/metawrap_50_10_bins -o ~/metawrap_run/bin_quant -a ~/megahit/S1S3_megehit/S1S3_final.contigs.fa ~/data_download/*fastq -t 16
