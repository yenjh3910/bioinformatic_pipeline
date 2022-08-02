#!/bin/bash

mkdir ~/ARGs_SARG
mkdir ~/virulence_factor

for i in {1..36}
do

#ARG-SARG detection
diamond blastx -d ~/Database/arg-oap/SARG.fasta.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 50 -p 16 -e 1e-7 -k 1 --query-cover 50 -o ~/ARGs_SARG/bin.$i.nucl.uniq.SARG.dmnd

#VF detection
diamond blastx -d ~/Database/vf.dmnd -q ~/cdhit/bin.$i.nucl.uniq --id 50 -p 16 -e 1e-7 -k 1 --query-cover 50 -o ~/virulence_factor/bin.$i.nucl.uniq.vf.dmnd

done
