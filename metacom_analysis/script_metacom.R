# Load the necessary libraries

library(metacom)
library(dplyr)
library(tidyr)
library(ggplot2)

#import input tables
asv <- read.table("metacom_table.txt", header = TRUE, check.names = FALSE)
metadata <- read.table("metadata.txt", header = TRUE, sep = "\t")


tt <- asv[, -2]
rownames(tt) <- tt$ASV
tt <- tt[, -1]
tt <- t(tt)
tt[tt>0] <- 1

#ordering data
ordermatrix3 <- OrderMatrix(tt)
rm(tt)

#reshaping the data
moltentt <- reshape2::melt(ordermatrix3)
moltentt$Var12 <- paste(moltentt$Var1, moltentt$Var2, sep = "_")

#merging with metadata
moltentt1 <- merge(moltentt, metadata, by.x = "Var1", by.y = "sample_ID", all.x = TRUE)
moltentt1$Var12 <- paste(moltentt1$Var1, moltentt1$Var2, sep = "_")
moltentt2 <- moltentt1[match(moltentt$Var12, moltentt1$Var12), ]

#assigning Climate Zone Labels:
moltentt3 <- moltentt2 %>%
  mutate(occ.czone = ifelse(value == 1 & climate.zone == "Tropical", "Tropical",
                            ifelse(value == 1 & climate.zone == "Temperate", "Temperate",
                                   ifelse(value == 1 & climate.zone == "Mediterranean", "Mediterranean",
                                          ifelse(value == 1 & climate.zone == "Polar", "Polar", "zz")))))

#creating the heatmap
g1 <- ggplot(moltentt3, aes(x = Var1, y = Var2, fill = as.factor(occ.czone))) +
  geom_tile() +
  scale_fill_manual(values = c("cyan3", "black", "royalblue", "orange", "#FFFFFF"),
                    labels = c("Mediterranean", "Nordic", "Temperate", "Equatorial", "")) +
  labs(x = "Samples", y = "ASVs", fill = "Climate zones") +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_text(size = 18),  
        axis.title.y = element_text(size = 18),  
        legend.text = element_text(size = 18),   
        legend.title = element_text(size = 18),
        legend.position = c(0.08, 0.10))

#saving the plot
ggsave(filename = "Figure_2.tiff", plot = g1, width = 15, height = 10, dpi = 300)

