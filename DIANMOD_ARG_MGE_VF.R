library(tidyverse)

#MGE
temp <- list.files(path = "//wsl$/Ubuntu/home/yen/MGEs/", pattern = "*.nucl.uniq.MGEs90.dmnd")
z<-read.table(paste("//wsl$/Ubuntu/home/yen/MGEs/", temp[1], sep = ''), header=F, stringsAsFac=F, sep='\t')
z$SampleID <- temp[1]
for (i in 2:length(temp)){
  z2 = read.table(paste("//wsl$/Ubuntu/home/yen/MGEs/", temp[i], sep = ''), header=F, stringsAsFac=F, sep='\t')
  z2$SampleID <- temp[i]
  z <- rbind(z, z2)
}
colnames(z) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "SampleID")
for (i in 1:dim(z)[1]) {
  z$Bin[i] <- paste(strsplit(z$SampleID[i], split='[.]')[[1]][1], strsplit(z$SampleID[i], split='[.]')[[1]][2], sep = '_')
}
head(z)
SHRiver.bin.MGE.bins <- z

#ARGminer
temp <- list.files(path = "//wsl$/Ubuntu/home/yen/ARGs/", pattern = "*.nucl.uniq.ARGminer.dmnd")
z<-read.table(paste("//wsl$/Ubuntu/home/yen/ARGs/", temp[1],sep = ''), header=F, stringsAsFac=F, sep='\t')
z$SampleID <- temp[1]
#delete sep='\t' from original sheet because i can't figure out the problems
for (i in 2:length(temp)){
  z2 = read.table(paste("//wsl$/Ubuntu/home/yen/ARGs/", temp[i], sep = ''), header=F, stringsAsFac=F)
  z2$SampleID <- temp[i]
  z <- rbind(z, z2)
}
colnames(z) <- c("qseqid", "sseqid", "pident", "length", "mismatch", "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore", "SampleID")
for (i in 1:dim(z)[1]) {
  z$Bin[i] <- paste(strsplit(z$SampleID[i], split='[.]')[[1]][1], strsplit(z$SampleID[i], split='[.]')[[1]][2], sep = '_')
}
SHRiver.bin.ARGminer.bins <- z

#VF
SHRiver.bin.VF.bins <-read.csv(file = "//wsl$/Ubuntu/home/yen/abricate/VF.table", header=T, sep="\t")

#Identity higher than 70% were selected and used
SHRiver.bin.MGE.bins.Covsel.id70 <- subset(SHRiver.bin.MGE.bins, pident >= 70)
SHRiver.bin.ARGminer.bins.Covsel.id70 <- subset(SHRiver.bin.ARGminer.bins, pident >= 70)
SHRiver.bin.VF.bins.CovSel.id70 <-  subset(SHRiver.bin.VF.bins, X.IDENTITY >= 70)

#Distinguish ARG & MGE with VF
z1 <- str_extract(SHRiver.bin.VF.bins.CovSel.id70$X.FILE, pattern = "bin.{1,4}.fa")
z1 <- str_replace(z1,".fa","")
z1 <- str_replace(z1,"n.","n_")
SHRiver.bin.VF.bins.CovSel.id70$X.FILE <- z1
names(SHRiver.bin.VF.bins.CovSel.id70)[1] <- "Bin"
vfbin<- unique(SHRiver.bin.VF.bins.CovSel.id70$Bin)
argbin <- unique(SHRiver.bin.ARGminer.bins.Covsel.id70$Bin)
arg_vfarb <- SHRiver.bin.ARGminer.bins.Covsel.id70 %>% filter(Bin %in% vfbin)
arg_arb <- SHRiver.bin.ARGminer.bins.Covsel.id70 %>% filter(!(Bin %in% vfbin))
mge_vfarb <- SHRiver.bin.MGE.bins.Covsel.id70 %>% filter(Bin %in% argbin) %>% filter(Bin %in% vfbin)
mge_arb <- SHRiver.bin.MGE.bins.Covsel.id70 %>% filter(Bin %in% argbin) %>% filter(!(Bin %in% vfbin))

#the annotated ARGs and MGEs were extracted by Seqkit
#delete other file except .gtf first
#ARG in VFARB
temp <- list.files(path = "//wsl$/Ubuntu/home/yen/prodigal/", pattern = "*.gtf")
temp2 <- list.files(path = "//wsl$/Ubuntu/home/yen/ARGs/", pattern = "*.dmnd")

for (i in 1:length(temp)){
  z = read.table(paste("//wsl$/Ubuntu/home/yen/prodigal/", temp[i], sep = ''), header=F, stringsAsFac=F, sep='\t')
  z <- filter(z,V3=="CDS")
  z1 <- str_extract(z$V9, pattern = "_.{1,3};")
  z1 <- str_replace(z1,";","")
  z$V10 <- z1
  z$V1 <- str_c(z$V1,z$V10)
  z <- select(z, -V10)
  z$V7 <- "+" 
  z$V5 <- z$V5-z$V4+1
  z$V4 <- 1
  z <- subset(z, V1 %in% arg_vfarb$qseqid)
  setwd("//wsl$/Ubuntu/home/yen/ARG_MGE_manually_gtf/")
  write.table(z, file=paste0(temp2[i],".vfarb.gtf.txt"), sep="\t",row.names = F,col.names = F,quote = F)
}#remove 0kb file by myself

#ARG in ARB
for (i in 1:length(temp)){
  z = read.table(paste("//wsl$/Ubuntu/home/yen/prodigal/", temp[i], sep = ''), header=F, stringsAsFac=F, sep='\t')
  z <- filter(z,V3=="CDS")
  z1 <- str_extract(z$V9, pattern = "_.{1,3};")
  z1 <- str_replace(z1,";","")
  z$V10 <- z1
  z$V1 <- str_c(z$V1,z$V10)
  z <- select(z, -V10)
  z$V7 <- "+" 
  z$V5 <- z$V5-z$V4+1
  z$V4 <- 1
  z <- subset(z, V1 %in% arg_arb$qseqid)
  setwd("//wsl$/Ubuntu/home/yen/ARG_MGE_manually_gtf/")
  write.table(z, file=paste0(temp2[i],".arb.gtf.txt"), sep="\t",row.names = F,col.names = F,quote = F)
}#remove 0kb file by myself

#MGE in VFARB
temp <- list.files(path = "//wsl$/Ubuntu/home/yen/prodigal/", pattern = "*.gtf")
temp2 <- list.files(path = "//wsl$/Ubuntu/home/yen/MGEs/", pattern = "*.dmnd")

for (i in 1:length(temp)){
  z = read.table(paste("//wsl$/Ubuntu/home/yen/prodigal/", temp[i], sep = ''), header=F, stringsAsFac=F, sep='\t')
  z <- filter(z,V3=="CDS")
  z1 <- str_extract(z$V9, pattern = "_.{1,3};")
  z1 <- str_replace(z1,";","")
  z$V10 <- z1
  z$V1 <- str_c(z$V1,z$V10)
  z <- select(z, -V10)
  z$V7 <- "+" 
  z$V5 <- z$V5-z$V4+1
  z$V4 <- 1
  z <- subset(z, V1 %in% mge_vfarb$qseqid)
  setwd("//wsl$/Ubuntu/home/yen/ARG_MGE_manually_gtf/")
  write.table(z, file=paste0(temp2[i],".vfarb.gtf.txt"), sep="\t",row.names = F,col.names = F,quote = F)
}#remove 0kb file by myself

#MGE in ARB
temp <- list.files(path = "//wsl$/Ubuntu/home/yen/prodigal/", pattern = "*.gtf")
temp2 <- list.files(path = "//wsl$/Ubuntu/home/yen/MGEs/", pattern = "*.dmnd")

for (i in 1:length(temp)){
  z = read.table(paste("//wsl$/Ubuntu/home/yen/prodigal/", temp[i], sep = ''), header=F, stringsAsFac=F, sep='\t')
  z <- filter(z,V3=="CDS")
  z1 <- str_extract(z$V9, pattern = "_.{1,3};")
  z1 <- str_replace(z1,";","")
  z$V10 <- z1
  z$V1 <- str_c(z$V1,z$V10)
  z <- select(z, -V10)
  z$V7 <- "+" 
  z$V5 <- z$V5-z$V4+1
  z$V4 <- 1
  z <- subset(z, V1 %in% mge_arb$qseqid)
  setwd("//wsl$/Ubuntu/home/yen/ARG_MGE_manually_gtf/")
  write.table(z, file=paste0(temp2[i],".arb.gtf.txt"), sep="\t",row.names = F,col.names = F,quote = F)
}#remove 0kb file by myself
