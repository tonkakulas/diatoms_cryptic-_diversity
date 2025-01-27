#load necessary libraries
library(scatterpie)
library(ggplot2)
library(dplyr)
library(ggpattern)

#plot for Figure 4
#import input table 
df <- read.table("table_for_Fig4.txt", sep= "\t", dec=".", header=TRUE)

# the quantile was calculated here as to define ranges of h line on plot
occur <- df$occurance

average <- df$avg_value

quantil_occurence <- quantile(occur, probs = seq(0, 1, 0.1))

quantil_avrg <- quantile(average, probs= seq(0, 1, 0.1))

#scaling part
df$nASV_scaled <- scales::rescale(df$nASV, to = c(0.15, 1)) 
df$occ <- df$occurance/50

#create the plot
p1 <- ggplot() +
  geom_hline(yintercept = 245, linetype = "dashed", color = "red") +
  geom_vline(xintercept = 3, linetype = "dashed", color = "red") +
  geom_scatterpie(aes(x = avg_value, y = occ, r = nASV_scaled, fill = climate_zone, linewidth=nASV_scaled), 
                  data = df, 
                  cols = c("Mediterranean", "Nordic", "Temperate", "Equatorial"), 
                  pie_scale = 1, color="black") + 
  coord_fixed() +
  scale_x_continuous(limits = c(0, 12)) +
  scale_y_continuous(limits = c(45, 645)) +
  scale_fill_manual(name = "Climate Zone", values = c("cyan3", "white", "lightskyblue", "orange"),
                    guide = guide_legend(order = 1)) +  
  scale_linewidth(range = c(0.2, 1), breaks = c(0.2, 0.6, 1)) + 
  scale_size_continuous(name = "Number of ASVs", range = c(1, 10), breaks = c(0.2, 0.5, 1), 
                        guide = guide_legend(order = 2)) +  
  theme_classic() +
  labs(x = "Average Abundance", y = "Number of sites occupied") +
  theme(
    legend.position = "right",          # Position the legend on the right (outside the plot)
    legend.justification = "center",    # Center the legend vertically
    legend.box = "vertical",            # Arrange the legends in a vertical box
    legend.text = element_text(size = 12),
    legend.title = element_text(size = 14),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12))


#save the plot
ggsave("Figure_4.tiff", p, width = 8 , height = 6 )




# Load necessary library
library(ggplot2)
library(ggpattern)


#create data frame, plot for Figure 6.
data <- data.frame(
  Category = c("Climate Zone", "Climate Zone", "Climate Zone", "Climate Zone", "Geographic Distance", "Geographic Distance"),
  Phylo_Signal = c("High", "Intermediate", "Low", "Not significant", "Low", "Not significant"),
  Percentage = c(33, 22, 42, 3, 63, 38)
)

#create a stacked bar plot
plot2 <- ggplot(data, aes(x = Category, y = Percentage, fill = Phylo_Signal)) +
  geom_bar(stat = "identity", position = "stack", color="black") +
  scale_fill_manual(values = c("High" = "gray30", "Intermediate" = "gray60", "Low" = "gray90", "Not significant"= "white")) +
  labs(x="",
       y = "Percentage of species",
       fill = "Phylogenetic signal")+
  theme_classic() +
  theme(
    legend.position = "right", 
    legend.title = element_text(size=12),
    legend.text = element_text(size=12),
    axis.title = element_text(size=12),
    axis.text.x = element_text(size= 11, face = "bold"),
    axis.text.y = element_text(size = 11, face="bold"))               


#save the plot
ggsave("Figure_6.tiff", plot2, width=8, height=6)




