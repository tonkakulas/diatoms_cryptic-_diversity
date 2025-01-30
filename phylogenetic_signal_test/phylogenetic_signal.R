#load necessary libraries

library(phylosignal)
library(adephylo)
library(ape)
library(phylobase)
library(pegas)
library(openxlsx)


#to calculate the phylogenetic signal tests for climate zones, the input data consisted of a generated phylogenetic tree for each species, 
#with metadata file detailing ASVs of presented species and its occurrences across climate zones 

rootpath <- "mypath"
setwd (dir = rootpath)


# Species present in 4 climate regions
vecteur <- c("Achnanthidium_minutissimum", "Achnanthidium_pyrenaicum", "Amphora_pediculus", 
             "Cocconeis_placentula", "Cymbella_excisa", "Eunotia_formica",  "Fistulifera_saprophila", 
             "Gomphonema_parvulum", "Gomphonema_pumilum", "Mayamaea_permitis", 
             "Navicula_cryptotenella", "Nitzschia_amphibia", "Nitzschia_filiformis",  
             "Nitzschia_inconspicua", "Nitzschia_linearis", "Nitzschia_palea",  
             "Planothidium_victori", "Sellaphora_nigri", "Sellaphora_pupula", "Sellaphora_saugeresii", 
             "Staurosira_construens", "Stephanocyclus_meneghinianus", "Ulnaria_ulna")

# Species present in 3 climate zones
# no Equatorial

vecteur2 <- c("Adlafia_minuscula", "Diploneis_subovalis", "Nitzschia_sigmoidea" , "Staurosira_venter",
              "Encyonema_lunatum", "Eunotia_bilunaris","Eunotia_glacialis", "Eunotia_minor" , "Eunotia_pectinalis" , "Nupela_indonesica" , "Pinnularia_subcapitata",
              "Gomphonema_affine" , "Nitzschia_fonticola")



##########################
# Create results files for species present in 4 climate zones 
##########################
# Cmeans
results_phylosignal_Cmeans <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_Cmeans) <- vecteur
results_phylosignal_Cmeans <- results_phylosignal_Cmeans[, -1]

results_phylosignal_Cmeans_p <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_Cmeans_p) <- vecteur
results_phylosignal_Cmeans_p <- results_phylosignal_Cmeans_p[, -1]

# I
results_phylosignal_I <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_I) <- vecteur
results_phylosignal_I <- results_phylosignal_I[, -1]

results_phylosignal_I_p <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)                                       
rownames(results_phylosignal_I_p) <- vecteur
results_phylosignal_I_p <- results_phylosignal_I_p[, -1]

# K
results_phylosignal_K <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
results_phylosignal_K <- results_phylosignal_K[, -1]

results_phylosignal_K_p <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)                                        
rownames(results_phylosignal_K_p) <- vecteur
results_phylosignal_K_p <- results_phylosignal_K_p[, -1]

# Kstar
results_phylosignal_Kstar <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_Kstar) <- vecteur
results_phylosignal_Kstar <- results_phylosignal_Kstar[, -1]

results_phylosignal_Kstar_p <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_Kstar_p) <- vecteur
results_phylosignal_Kstar_p <- results_phylosignal_Kstar_p[, -1]


# Lambda
results_phylosignal_Lambda <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_Lambda) <- vecteur
results_phylosignal_Lambda <- results_phylosignal_Lambda[, -1]

results_phylosignal_Lambda_p <- data.frame(vecteur, Equatorial = 0, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results_phylosignal_Lambda_p) <- vecteur
results_phylosignal_Lambda_p <- results_phylosignal_Lambda_p[, -1]



##########################
# Create results files for species present in 3 climate zones  
##########################
# Cmeans
results2_phylosignal_Cmeans <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results2_phylosignal_Cmeans) <- vecteur2
results2_phylosignal_Cmeans <- results2_phylosignal_Cmeans[, -1]

results2_phylosignal_Cmeans_p <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)                                      
rownames(results2_phylosignal_Cmeans_p) <- vecteur2
results2_phylosignal_Cmeans_p <- results2_phylosignal_Cmeans_p[, -1]

# I
results2_phylosignal_I <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)
results2_phylosignal_I <- results2_phylosignal_I[, -1]

results2_phylosignal_I_p <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)                                       
rownames(results2_phylosignal_I_p) <- vecteur2
results2_phylosignal_I_p <- results2_phylosignal_I_p[, -1]

# K
results2_phylosignal_K <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results2_phylosignal_K) <- vecteur2
results2_phylosignal_K <- results2_phylosignal_K[, -1]

results2_phylosignal_K_p <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)                                      
rownames(results2_phylosignal_K_p) <- vecteur2
results2_phylosignal_K_p <- results2_phylosignal_K_p[, -1]

# Kstar
results2_phylosignal_Kstar <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results2_phylosignal_Kstar) <- vecteur2
results2_phylosignal_Kstar <- results2_phylosignal_Kstar[, -1]

results2_phylosignal_Kstar_p <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)                                        
rownames(results2_phylosignal_Kstar_p) <- vecteur2
results2_phylosignal_Kstar_p <- results2_phylosignal_Kstar_p[, -1]


# Lambda
results2_phylosignal_Lambda <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)
rownames(results2_phylosignal_Lambda) <- vecteur2
results2_phylosignal_Lambda <- results2_phylosignal_Lambda[, -1]

results2_phylosignal_Lambda_p <- data.frame(vecteur2, Nordic = 0, Temperate = 0, Mediterranean = 0)                                       
rownames(results2_phylosignal_Lambda_p) <- vecteur2
results2_phylosignal_Lambda_p <- results2_phylosignal_Lambda_p[, -1]
##########################



######################################## 
### LOOP for species in 4 climate zones
########################################

for (i in vecteur) {
  
  TreePath <- paste(rootpath, i, ".tre", sep = "")
  tr1 <- read.tree(file = TreePath)
  plot(tr1)
  
  order <- tr1$tip.label #ASV ordered as they are in the phylogeny
  order_asv <- as.data.frame(order)
  rownames(order_asv) <- order
  colnames(order_asv) [1] <- "ASV"
  order_asv$ASV_tree_order <- seq(1, nrow(order_asv))
  
  TxtPath <- paste(rootpath, i, ".txt", sep = "") 
  Txtfile <- read.delim(TxtPath) #read the file with # of ASV read in each climate zone
  nom_asv <- Txtfile[,1]
  row.names(Txtfile)=nom_asv
  colnames(Txtfile) [1] <- "ASV" 
  
  merged <- merge(order_asv, Txtfile, by = "ASV", all = TRUE) #merge table with ASV tree order and ASVtable with their read number in each climate zone  
  merged_sorted <- merged[order(merged$ASV_tree_order), ] #sort the merged table with ASV tree order
  rownames(merged_sorted)  <- order
  
  merged_sorted <- merged_sorted[, !names(merged_sorted) %in% 
                                   c("ASV", "ASV_tree_order", "occurance")] #remove unnecessary columns
  
  ASV_climate_frequency <- t(apply(merged_sorted, 1, function(x) x/sum(x))) #transform read in %
  
  
  p1d <- phylo4d(tr1, ASV_climate_frequency) 
  
 
  gridplot.phylo4d(p1d, tree.type = "phylogram", tree.ladderize = TRUE, center = FALSE)
  
  result <- phyloSignal(p4d = p1d, method = "all")
  
  #Cmeans results
  results_phylosignal_Cmeans[i, ] <- result$stat$Cmean
  results_phylosignal_Cmeans_p[i, ]  <- result$pvalue$Cmean
  #I results
  results_phylosignal_I[i, ] <- result$stat$I
  results_phylosignal_I_p[i, ]  <- result$pvalue$I
  #K results
  results_phylosignal_K[i, ] <- result$stat$K
  results_phylosignal_K_p[i, ]  <- result$pvalue$K
  #Kstar results
  results_phylosignal_Kstar[i, ] <- result$stat$K.star
  results_phylosignal_Kstar_p[i, ]  <- result$pvalue$K.star
  #Lambda
  results_phylosignal_Lambda[i, ] <- result$stat$Lambda
  results_phylosignal_Lambda_p[i, ]  <- result$pvalue$Lambda
  
  
}


#Save results with openexlsx package 
wb <- createWorkbook()

addWorksheet(wb, "Cmean_p")
writeData(wb, sheet = "Cmean_p", rowNames = TRUE, results_phylosignal_Cmeans_p)

addWorksheet(wb, "I")
writeData(wb, sheet = "I", rowNames = TRUE, results_phylosignal_I_p)

addWorksheet(wb, "K")
writeData(wb, sheet = "K", rowNames = TRUE, results_phylosignal_K_p)

addWorksheet(wb, "Kstar")
writeData(wb, sheet = "Kstar", rowNames = TRUE, results_phylosignal_Kstar_p)

addWorksheet(wb, "Lambda_p")
writeData(wb, sheet = "Lambda_p", rowNames = TRUE, results_phylosignal_Lambda_p)


#Save results with openexlsx package 
saveWorkbook(wb, file = "phylogenetic_signal_pvalues.xlsx", overwrite = TRUE)


######################################## 
### LOOP for species in 3 climate zones
########################################

for (j in vecteur2) {
  
  
  TreePath <- paste(rootpath2, j, ".tre", sep = "")
  tr1 <- read.tree(file = TreePath)
  plot(tr1)
  
  order <- tr1$tip.label #ASV ordered as they are in the phylogeny
  order_asv <- as.data.frame(order)
  rownames(order_asv) <- order
  colnames(order_asv) [1] <- "ASV"
  order_asv$ASV_tree_order <- seq(1, nrow(order_asv))
  
  TxtPath <- paste(rootpath2, j, ".txt", sep = "") 
  Txtfile <- read.delim(TxtPath) #read the file with # of ASV read in each climate zone
  nom_asv <- Txtfile[,1]
  row.names(Txtfile)=nom_asv
  colnames(Txtfile) [1] <- "ASV" 
  
  merged <- merge(order_asv, Txtfile, by = "ASV", all = TRUE) #merge table with ASV tree order and ASVtable with their read number in each climate zone  
  merged_sorted <- merged[order(merged$ASV_tree_order), ] #sort the merged table with ASV tree order
  rownames(merged_sorted)  <- order
  
  merged_sorted <- merged_sorted[, !names(merged_sorted) %in% 
                                   c("ASV", "ASV_tree_order", "occurance")] #remove unnecessary columns
  
  ASV_climate_frequency <- t(apply(merged_sorted, 1, function(x) x/sum(x))) #transform read in %
  
  
  p1d <- phylo4d(tr1, ASV_climate_frequency) 
  
  result2 <- phyloSignal(p4d = p1d, method = "all")
  
  #Cmeans results
  results2_phylosignal_Cmeans[j, ] <- result2$stat$Cmean
  results2_phylosignal_Cmeans_p[j, ]  <- result2$pvalue$Cmean
  #I results
  results2_phylosignal_I[j, ] <- result2$stat$I
  results2_phylosignal_I_p[j, ]  <- result2$pvalue$I
  #K results
  results2_phylosignal_K[j, ] <- result2$stat$K
  results2_phylosignal_K_p[j, ]  <- result2$pvalue$K
  #Kstar results
  results2_phylosignal_Kstar[j, ] <- result2$stat$K.star
  results2_phylosignal_Kstar_p[j, ]  <- result2$pvalue$K.star
  #Lambda
  results2_phylosignal_Lambda[j, ] <- result2$stat$Lambda
  results2_phylosignal_Lambda_p[j, ]  <- result2$pvalue$Lambda
  
  
}



#Save results with openexlsx package 
wb2 <- createWorkbook()

addWorksheet(wb2, "Cmean_p")
writeData(wb2, sheet = "Cmean_p", rowNames = TRUE, results2_phylosignal_Cmeans_p)

addWorksheet(wb2, "I")
writeData(wb2, sheet = "I", rowNames = TRUE, results2_phylosignal_I_p)

addWorksheet(wb2, "K")
writeData(wb2, sheet = "K", rowNames = TRUE, results2_phylosignal_K_p)

addWorksheet(wb2, "Kstar")
writeData(wb2, sheet = "Kstar", rowNames = TRUE, results2_phylosignal_Kstar_p)

addWorksheet(wb2, "Lambda_p")
writeData(wb2, sheet = "Lambda_p", rowNames = TRUE, results2_phylosignal_Lambda_p)


#Save results with openexlsx package 
saveWorkbook(wb2, file = "phylogenetic_signal_pvalues_3climate.xlsx", overwrite = TRUE)

