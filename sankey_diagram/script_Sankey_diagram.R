#load necessary libraries

library(networkD3)
library(htmlwidgets)
library(webshot)

##Sankey diagram, Figure 3.
# define nodes nb of ASV all along the Sankey + 11 nodes (only one climate zone whaterver we have assigned / non assigned ASV)

nodes <- data.frame(name = c("Total number of ASVs (3302)",  # 0
                             "Assigned ASVs (1905)",         # 1
                             "Not Assigned ASVs (1397)",     # 2
                             "Cosmopolitan (897)",           # 3
                             "Endemic (1008)",                # 4
                             "Cosmopolitan (376)",           # 5
                             "Endemic (1021)",                # 6
                             "Mediterranean",       # 7
                             "Equatorial",          # 8
                             "Nordic",              # 9
                             "Temperate"           # 10
))

# Define links with correct flow, now directed to separate climate zone nodes
links <- data.frame(source = c(0, 0,           # From Total ASVs to Assigned and Not Assigned
                               1, 1, 2, 2,     # From Assigned and Not Assigned to Cosmopolitan and Endemic
                               3, 3, 3, 3,     # From Assigned Cosmopolitan to climate zones
                               4, 4, 4, 4,     # From Assigned Endemic to climate zones
                               5, 5, 5, 5,     # From Not Assigned Cosmopolitan to climate zones
                               6, 6, 6, 6),    # From Not Assigned Endemic to climate zones
                    target = c(1, 2,           # Links from Total ASVs to Assigned and Not Assigned
                               3, 4, 5, 6,     # Links from Assigned and Not Assigned to Cosmopolitan and Endemic
                               7, 8, 9, 10,    # Links from Assigned Cosmopolitan to climate zones
                               7, 8, 9, 10,    # Links from Assigned Endemic to climate zones
                               7, 8, 9, 10,    # Links from Not Assigned Cosmopolitan to climate zones
                               7, 8, 9, 10),   # Links from Not Assigned Endemic to climate zones
                    value = c(1905, 1397,          # Total ASVs to Assigned (58%) and Not Assigned (42%)
                              897, 1008, 376, 1021,  # Assigned/Not Assigned split into Cosmopolitan and Endemic
                              # for the next values, given that some ASV could be present in several climate zones (cosmopolite), some proportions were calculated based on the nb of asv
                              290.81, 110.04, 141.47, 353.68,  # Assigned Cosmopolitan to climate zones
                              95.19, 418.83, 266.53, 228.45,   # Assigned Endemic to climate zones
                              117.00, 26.00, 71.50, 162.50,   # Not Assigned Cosmopolitan to climate zones
                              55.89, 670.68, 195.62, 97.81)    # Not Assigned Endemic to climate zones
)

# Define a color scale for the nodes with custom colors for climate zones and other categories
color_scale <- 'd3.scaleOrdinal()
               .domain(["Total number of ASVs (3302)", "Assigned ASVs (1905)", "Not Assigned ASVs (1397)", 
                        "Cosmopolitan (896)", "Endemic (1009)", 
                        "Cosmopolitan (377)", "Endemic (1020)", 
                        "Mediterranean", "Equatorial", "Nordic", "Temperate"])
               .range(["#8c8c8c", "#66c2a5", "#1f78b4",  // Gray, teal green, and a medium blue for main groups
                       "#6a3d9a", "#b15928",             // Vibrant colors for Assigned cosmopolitan/endemic
                       "#6a3d9a", "#b15928",             // Different shades for Not assigned cosmopolitan/endemic
                       "#00ffff", "#ffa500", "#ffffff", "#4169e1"])' 

# Create the Sankey diagram with custom colors
sankey <- sankeyNetwork(Links = links, Nodes = nodes, 
                        Source = "source", Target = "target", 
                        Value = "value", NodeID = "name", 
                        units = "ASVs",
                        fontSize = 17,    # Adjust font size
                        nodeWidth = 15,   # Control the width of the nodes
                        nodePadding = 10, # Control the padding between nodes
                        sinksRight = FALSE, # Arrange the flow from left to right
                        colourScale = color_scale # Apply custom color scale
)

# Print the Sankey diagram with color customization
print(sankey)


html_file <- "sankey_diagram.html"
saveNetwork(sankey, file = html_file)

# Use webshot to save the Sankey diagram as a PNG
png_file <- "sankey_diagram.png"
webshot(html_file, png_file, delay = 0.2, cliprect = "viewport")




###Sankey diagram, Figure 7

# Define nodes 

nodes <- data.frame(name = c("36 species", 
                             "High Phylogenetic Signal\n(Strong geographic pattern\nbetween climate zones)", 
                             "Medium Phylogenetic Signal\n(Weak geographic pattern\nbetween climate zones)", 
                             "Low Phylogenetic Signal\n(Weak/no geographic pattern\nbetween climate zones)", 
                             "No Phylogenetic signal", 
                             "Community phylogenetic overclustering\nStrong environmental filtering", 
                             "Intermediate community phylogenetic overclustering\nIntermediate environmental filtering",
                             "Weak community phylogenetic overclustering\nWeak environmental filtering"))

links <- data.frame(source = c(0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4),
                    target = c(1, 2, 3, 4, 5, 6, 7, 5, 6, 7, 5, 6, 7, 7),
                    value = c(33, 22, 42, 3, 22, 8, 3, 11, 8, 3, 6, 14, 25, 3))

color_scale <- 'd3.scaleOrdinal()
                .domain(["36 species", "High Phylogenetic Signal", "Medium Phylogenetic Signal", "Low Phylogenetic Signal", 
                         "No Phylogenetic signal", "Community phylogenetic overclustering", "Intermediate community phylogenetic overclustering",
                         "Weak community phylogenetic overclustering"])
                .range(["#c2e699", "#66c2a5", "#b15928", "#8da0cb", "#ff6347", "#4169e1", "#ffa500", "#ff0000"])'

sankey3 <- sankeyNetwork(Links = links, Nodes = nodes, 
                         Source = "source", Target = "target", 
                         Value = "value", NodeID = "name", 
                         units = "Flow",
                         fontSize = 17, 
                         fontFamily = "Arial",
                         nodeWidth = 20, 
                         nodePadding = 10, 
                         sinksRight = FALSE, 
                         colourScale = color_scale)

# Add custom JavaScript rendering
sankey3 <- htmlwidgets::onRender(
  sankey3, 
  '
  function(el) {
    var svg = d3.select(el).select("svg");
    
    // Add column titles
    svg.append("text")
      .attr("x", 350)
      .attr("y", 10)
      .attr("font-size", "16px")
      .attr("font-family", "Arial") 
      .attr("font-weight", "bold")
      .attr("text-anchor", "middle")
      .text("Phylogenetic Signal");
    
    svg.append("text")
      .attr("x", 700)
      .attr("y", 10)
      .attr("font-size", "16px")
      .attr("font-family", "Arial") //
      .attr("font-weight", "bold")
      .attr("text-anchor", "middle")
      .text("Phylogenetic Community Structure");
    
    // Handle multiline node labels
    svg.selectAll(".node text")
      .each(function() {
        var text = d3.select(this);
        var lines = text.text().split("\\n");
        text.text("");
        lines.forEach(function(line, i) {
          text.append("tspan")
              .text(line)
              .attr("x", 22)
              .attr("dy", i === 0 ? 0 : "1.2em");
        });
      });
  }
  '
)

sankey3

# Save the Sankey diagram as an HTML file
html_file <- "sankey_diagram_phylocorrected_new.html"
saveNetwork(sankey3, file = html_file)

# Save as PNG using webshot
png_file <- "sankey_diagram_phylo_new.png"
webshot(html_file, png_file, delay = 0.5, cliprect = "viewport")


