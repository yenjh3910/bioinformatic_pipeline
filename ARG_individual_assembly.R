library(tidyverse)

temp <- list.files(path = "//wsl$/Ubuntu/home/yen/individual_assembly_arg/", pattern = "*._assembly.nucl.ARGminer.dmnd")
z<-read.table(paste("//wsl$/Ubuntu/home/yen/individual_assembly_arg/", temp[1], sep = ''))
z$SampleID <- temp[1]
for (i in 2:length(temp)){
  z2 = read.table(paste("//wsl$/Ubuntu/home/yen/individual_assembly_arg/", temp[i], sep = ''))
  z2$SampleID <- temp[i]
  z <- rbind(z, z2)
}
colnames(z) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "SampleID")
for (i in 1:dim(z)[1]) {
  z$Bin[i] <- paste(strsplit(z$SampleID[i], split='[.]')[[1]][1], strsplit(z$SampleID[i], split='[.]')[[1]][2], sep = '_')
}
head(z)
ARGminer_individual_assembly <- z
ARGminer_individual_assembly.id70 <- subset(ARGminer_individual_assembly, pident >= 70)

temp <- list.files(path = "//wsl$/Ubuntu/home/yen/assembly_prodigal/", pattern = "*.gtf")
temp2 <- list.files(path = "//wsl$/Ubuntu/home/yen/individual_assembly_arg/", pattern = "*.dmnd")

for (i in 1:length(temp)){
  z = read.table(paste("//wsl$/Ubuntu/home/yen/assembly_prodigal/", temp[i], sep = ''), header=F, stringsAsFac=F, sep='\t')
  z <- filter(z,V3=="CDS")
  z1 <- str_extract(z$V9, pattern = "_.{1,3};")
  z1 <- str_replace(z1,";","")
  z$V10 <- z1
  z$V1 <- str_c(z$V1,z$V10)
  z <- select(z, -V10)
  z$V7 <- "+" 
  z$V5 <- z$V5-z$V4+1
  z$V4 <- 1
  z <- subset(z, V1 %in% ARGminer_individual_assembly.id70$qseqid)
  setwd("//wsl$/Ubuntu/home/yen/individual_assembly_arg_manually_gff/")
  write.table(z, file=paste0(temp2[i],".arg.gtf.txt"), sep="\t",row.names = F,col.names = F,quote = F)
}
