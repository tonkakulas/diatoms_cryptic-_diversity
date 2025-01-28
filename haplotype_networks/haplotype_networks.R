#before starting with haplotype networks and other phylogenetic analysis 
#the selection of species was based on ASV counts per species and determined statistically using quantile analysis

quantil  <- read.table("Table_S4.txt", sep="\t", dec=".", header = TRUE)

nASV  <- quantil$nASV

q <- quantile(nASV, probs=seq(0,1,0.1))




#load necessary libraries

library(ape)
library(pegas)


vecteur <- c("Sellaphora_nigri", "Eunotia_glacialis", "Achnanthidium_minutissimum", "Nitzschia_palea",
             "Navicula_cryptotenella", "Sellaphora_pupula", "Sellaphora_saugerresii", "Amphora_pediculus", "Nitzschia_filiformis", 
             "Gomphonema_parvulum", "Nitzschia_linearis", "Nitzschia_inconspicua", "Fistulifera_saprophila", "Nitzschia_sigmoidea", 
             "Ulnaria_ulna", "Cocconeis_placentula", "Gomphonema_affine", "Cymbella_excisa", "Staurosira_venter", "Eunotia_bilunaris",
             "Achnanthidium_pyrenaicum", "Eunotia_minor", "Diploneis_subovalis", "Mayamaea_permitis", "Staurosira_construens",
             "Stephanocyclus_meneghinianus", "Eunotia_formica", "Nitzschia_fonticola", "Gomphonema_pumilum_var._pumilum","Nitzschia_amphibia",
             "Adlafia_minuscula", "Encyonema_lunatum", "Eunotia_pectinalis", "Nupela_indonesica", "Pinnularia_subcapitata", "Planothidium_victori")

# define your file path
# replace "yourfilepath" in the loop with the actual path to your file


for (i in vecteur) {
  
  myPath <- ("yourfilepath", i, ".fasta", sep = "")
  
  print(myPath)
  
  fasta <- read.dna(file = filepath,"fasta")
  
  hap.div(fasta, TRUE)
  h <- haplotype(fasta)
  plot(h)
  net <- haploNet(h)
  plot(net)
  
  #here matadata is provided for each species containing how many times 
  #each ASV of that species appears in a particular climate zone and its the total occurrence
  metadata_path <- paste ("matadata_path", i, ".txt", sep = "", header=T)
  metadata <- read.delim(metadata_path, row.names=1)
  
  sz <- log(metadata$occurance)
  
  plot(net, size= sz)
  

  S <- list()
  
  S$Mediterranean <- metadata$Mediterranean
  
  S$Nordic <- metadata$Nordic
  
  S$Temperate <- metadata$Temperate
  
  S$Equatorial<- metadata$Equatorial
  
  S <- as.data.frame(S)
  
  R <- as.matrix(S)
  
  
  savetiff <- "name_of_your_file.tiff"  
  
  # Open a TIFF device
  tiff(file = savetiff, width = 7, height = 7, units = "in", res = 300) 
  
  custom_colors <- c("cyan3", "white", "lightskyblue", "orange")
  
  setHaploNetOptions(labels = FALSE, pie.colors.function = function(n) custom_colors[1:n])
  
  plot(net, size = sz, pie = R, legend=FALSE)
  
  dev.off()
  
  
}

