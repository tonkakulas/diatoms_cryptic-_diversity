#load necessary libraries
library(vegan)
library(dplyr)
library(ggplot2)
library(reshape2)
library(tidyr)
library(pheatmap)
library(ggdendro)
library(grid)


df2 <- read.table("table_heatmap_NRI_NTI.txt", sep="\t", dec=".", header=TRUE)


# Prepare the data
species_names <- gsub("([[:alpha:]]+)_([[:alpha:]]+)", "\\1 \\2", df2$Species)
df2$Species <- species_names
rownames(df2) <- df2$Species
df2[, c(1)] <- NULL


# Perform hierarchical clustering
hc <- hclust(dist(df2), method = "ward.D2")

# Determine truncation level for clustering into desired groups
desired_groups <- 4  # Change this to the number of groups you want
clusters <- cutree(hc, k = desired_groups)
trunc_height <- hc$height[length(hc$height) - (length(unique(clusters)) - 1)]

# Create the heatmap
g1 <- pheatmap(
  df2,
  clustering_method = "ward.D2",
  cluster_cols = FALSE,
  fontsize = 14,
  angle_col = 0
)



tiff("mypath/Suppplement_Fig_2.tiff", width = 10, height = 10, units = "in", res = 300)

# Draw the heatmap and the vertical line with x and y you are placing the red line
grid::grid.newpage()
grid::grid.draw(g1$gtable)
grid::grid.lines(
  x = unit(0.06, "npc"),  
  y = unit(c(0, 1), "npc"), 
  gp = grid::gpar(col = "red", lty = 2, lwd = 2)
)


dev.off()
