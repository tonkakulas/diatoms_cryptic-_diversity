mypath <-'set your path'
setwd(mypath)

#load necessary library
library(ape)

### RAXML function is implemented in the ips package
###go to https://cme.h-its.org/exelixis/web/software/raxml/index.html
###follow : github https://github.com/stamatak/standard-RAxML
### for windows option: https://github.com/stamatak/standard-RAxML/tree/master/WindowsExecutables_v8.2.10
###download the raxml executable "raxmlHPC-PTHREADS-AVX.exe"
###put the executable in your following path 
###give the path to the raxml executable 

#load necessary libraries
library (devtools)
library(ips)

exec <- "/yourpath/raxmlHPC-PTHREADS-AVX.exe"

# use adegenet package to transform fasta files into DNAbin files (used in ips)

library(adegenet)

# for NRI and NTI calculation use picante package

library(picante)

#to read Excel files
library (readxl)

#firstly create excel table where results of NRI and NTI will be saved

sample <- read_excel("Diatom.xlsx", sheet = "sample_list")
results_nti_p <- data.frame(sample, Sellaphora_nigri= 0, Eunotia_glacialis = 0, Achnanthidium_minutissimum = 0, 
                            Nitzschia_palea= 0,Navicula_cryptotenella = 0, Sellaphora_pupula = 0, Sellaphora_saugerresii = 0, 
                            Amphora_pediculus = 0, Nitzschia_filiformis = 0, Gomphonema_parvulum = 0, Nitzschia_linearis = 0, 
                            Nitzschia_inconspicua = 0,Fistulifera_saprophila = 0,Nitzschia_sigmoidea = 0, Ulnaria_ulna = 0, 
                            Cocconeis_placentula = 0, Gomphonema_affine = 0, Cymbella_excisa = 0, Staurosira_venter = 0, Eunotia_bilunaris = 0,
                            Achnanthidium_pyrenaicum = 0, Eunotia_minor = 0, Diploneis_subovalis = 0, Mayamaea_permitis = 0, Staurosira_construens = 0,
                            Stephanocyclus_meneghinianus = 0, Eunotia_formica = 0, Nitzschia_fonticola = 0, Gomphonema_pumilum_var._pumilum = 0,
                            Nitzschia_amphibia = 0,Adlafia_minuscula = 0, Encyonema_lunatum = 0, Eunotia_pectinalis = 0, Nupela_indonesica = 0, 
                            Pinnularia_subcapitata= 0, Planothidium_victori = 0)


results_nri_p <- data.frame(sample, Sellaphora_nigri= 0, Eunotia_glacialis = 0, Achnanthidium_minutissimum = 0, 
                            Nitzschia_palea= 0,Navicula_cryptotenella = 0, Sellaphora_pupula = 0, Sellaphora_saugerresii = 0, 
                            Amphora_pediculus = 0, Nitzschia_filiformis = 0, Gomphonema_parvulum = 0, Nitzschia_linearis = 0, 
                            Nitzschia_inconspicua = 0,Fistulifera_saprophila = 0,Nitzschia_sigmoidea = 0, Ulnaria_ulna = 0, 
                            Cocconeis_placentula = 0, Gomphonema_affine = 0, Cymbella_excisa = 0, Staurosira_venter = 0, Eunotia_bilunaris = 0,
                            Achnanthidium_pyrenaicum = 0, Eunotia_minor = 0, Diploneis_subovalis = 0, Mayamaea_permitis = 0, Staurosira_construens = 0,
                            Stephanocyclus_meneghinianus = 0, Eunotia_formica = 0, Nitzschia_fonticola = 0, Gomphonema_pumilum_var._pumilum = 0,
                            Nitzschia_amphibia = 0,Adlafia_minuscula = 0, Encyonema_lunatum = 0, Eunotia_pectinalis = 0, Nupela_indonesica = 0, 
                            Pinnularia_subcapitata= 0, Planothidium_victori = 0)

results_nri_obs <- data.frame(sample, Sellaphora_nigri= 0, Eunotia_glacialis = 0, Achnanthidium_minutissimum = 0, 
                              Nitzschia_palea= 0,Navicula_cryptotenella = 0, Sellaphora_pupula = 0, Sellaphora_saugerresii = 0, 
                              Amphora_pediculus = 0, Nitzschia_filiformis = 0, Gomphonema_parvulum = 0, Nitzschia_linearis = 0, 
                              Nitzschia_inconspicua = 0,Fistulifera_saprophila = 0,Nitzschia_sigmoidea = 0, Ulnaria_ulna = 0, 
                              Cocconeis_placentula = 0, Gomphonema_affine = 0, Cymbella_excisa = 0, Staurosira_venter = 0, Eunotia_bilunaris = 0,
                              Achnanthidium_pyrenaicum = 0, Eunotia_minor = 0, Diploneis_subovalis = 0, Mayamaea_permitis = 0, Staurosira_construens = 0,
                              Stephanocyclus_meneghinianus = 0, Eunotia_formica = 0, Nitzschia_fonticola = 0, Gomphonema_pumilum_var._pumilum = 0,
                              Nitzschia_amphibia = 0,Adlafia_minuscula = 0, Encyonema_lunatum = 0, Eunotia_pectinalis = 0, Nupela_indonesica = 0, 
                              Pinnularia_subcapitata= 0, Planothidium_victori = 0)

results_nti_obs <- data.frame(sample, Sellaphora_nigri= 0, Eunotia_glacialis = 0, Achnanthidium_minutissimum = 0, 
                              Nitzschia_palea= 0,Navicula_cryptotenella = 0, Sellaphora_pupula = 0, Sellaphora_saugerresii = 0, 
                              Amphora_pediculus = 0, Nitzschia_filiformis = 0, Gomphonema_parvulum = 0, Nitzschia_linearis = 0, 
                              Nitzschia_inconspicua = 0,Fistulifera_saprophila = 0,Nitzschia_sigmoidea = 0, Ulnaria_ulna = 0, 
                              Cocconeis_placentula = 0, Gomphonema_affine = 0, Cymbella_excisa = 0, Staurosira_venter = 0, Eunotia_bilunaris = 0,
                              Achnanthidium_pyrenaicum = 0, Eunotia_minor = 0, Diploneis_subovalis = 0, Mayamaea_permitis = 0, Staurosira_construens = 0,
                              Stephanocyclus_meneghinianus = 0, Eunotia_formica = 0, Nitzschia_fonticola = 0, Gomphonema_pumilum_var._pumilum = 0,
                              Nitzschia_amphibia = 0,Adlafia_minuscula = 0, Encyonema_lunatum = 0, Eunotia_pectinalis = 0, Nupela_indonesica = 0, 
                              Pinnularia_subcapitata= 0, Planothidium_victori = 0)


rm(sample)


for (i in vector) {
  
  
  ### Phylogeny
  ## read the fasta file where is your full length sequences 
  myPath <- paste("mypath/fasta/", i, ".fasta", sep = "")
  ## and transform into dnabin format (required format for ips)
  obj <- fasta2DNAbin(myPath, chunk=10) # process 10 sequences at a time
  
  ##run a raxml phylogeny with rapid bootstrap
  tr <- raxml(obj, 
              m = "GTRGAMMA", # m = substitution model
              f = "a", # f = raxml algo ("a" ML+rapid bootstrap, "d" ML search)
              N = 500, # N: number of bootstrap - other bootstopping criteria can be chosen
              p = 1234,#random seed
              x = 4321, # setting a random seed for rapid bootstrapping
              threads = 4,#number of threads
              exec = exec)
  
  # plot phylogeny and save tree in .pdf
  
  savepdf <- paste(i,".pdf",sep="")
  pdf(file=savepdf)
  plot(tr$bestTree)
  edgelabels(round(tr$bestTree$edge.length,3), col="blue", bg = "white", adj = c(0.5, -0.25), font=1)
  dev.off()
  
  
  # save tree in newick format .tre
  besttree <- paste(i,".tre", sep = "")
  write.tree(tr$bestTree, file = besttree )
  
  # From the tree retrieve the distances between sequences 
  distfromtree <- cophenetic(tr$bestTree)
  distfromtree <- distfromtree [order(rownames(distfromtree)), 
                                order(colnames(distfromtree))]  #give the same order of the ASV in community and distfromtree
  
  #The data must be in matrix format (not a dataframe)
  distfromtree <- as.matrix(distfromtree)
  
  
  ###  CALCULATION NRI NTI 
  ## load your communities data from  community-asv.cvs 
  
  community <- as.data.frame(read_excel(paste("mypath/data/", i, ".xlsx", sep=""), sheet = "Sheet1"))
  
  row.names(community) <- community$ASV
  community <- community[-1,-1]
  community <- t(as.matrix(community[order(rownames(community)),])) #give the same order of the ASV in community and distfromtree and order the ASV
  
  # calculation of the mean phylogenetic distance -mpd- 
  PhyloDistAverage <- mpd(community, distfromtree, abundance.weighted=TRUE)
  # write.csv(PhyloDistAverage, file= "PhyloDistAverage.csv")
  
  # calculation of ses.mpd (=-1xNRI Net Relatedness Index). 
  NRI <- ses.mpd(community, distfromtree, abundance.weighted = TRUE, runs = 999, iterations = 1000)
  
  
  # calculation of ses.mntd (=-1xNTI Nearest Taxon Index). 
  NTI <- ses.mntd(community, distfromtree, abundance.weighted = TRUE, runs = 999, iterations = 1000)
  
  
  # integrate NRI and NTI p values in the results table
  results_nri_p[, i] <- NRI$mpd.obs.p
  results_nti_p[, i] <- NTI$mntd.obs.p
  
  # integrate NRI and NTI observed  values in the results table
  results_nri_obs[, i] <- NRI$mpd.obs.z
  results_nti_obs[, i] <- NTI$mntd.obs.z
  
}




write.csv(results_nri_p, file.path(mypath,"results_nri_p.csv"))
write.csv(results_nti_p, file.path(mypath,"results_nti_p.csv"))
write.csv(results_nri_obs, file.path(mypath,"results_nri_obs.csv"))
write.csv(results_nti_obs, file.path(mypath,"results_nti_obs.csv"))

