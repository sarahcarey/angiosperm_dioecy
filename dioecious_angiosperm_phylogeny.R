#### R script for the manuscript by S.B.Carey, L.Akozbek, and A.Harkess 
#### titled "The contributions of Nettie Stevens to the field of sex chromosome biology"

#### Specifically, this script will generate the heatmap for dioecious angiosperms (Fig. 3)
### Script by S.B. Carey

## Script was run using R v4.1.1

######### Install packages #########
## install all packages used in this script (versions used are next to package name)

# ggplot2 v3.3.5
#install.packages("ggplot2")

# ggtree v3.0.4
#BiocManager::install("ggtree")

######### Figures #########

##### Fig. 3 #####

library("ggtree")
library("ggplot2")

counts <- read.csv("dioecious_angios.csv", header=TRUE, check.names=FALSE)

angio_tree <- read.tree("angiosperm_orders.tree")

rownames(counts) <- counts[,1]
counts[,1] <- NULL
counts[1:3] <- lapply(counts[1:3], as.numeric)


tree_plot <- ggtree(angio_tree, branch.length = "none",
                    size=1, color="gray75") +
  geom_tiplab(size=3.5, color="black") +
  xlim(NA,60) +
  theme_tree("white") 

heatmap <- gheatmap(tree_plot, log(counts), offset=7, width=0.25,
                    colnames_angle = 0, colnames_position="top",
                    colnames_offset_y=0.5) +
  scale_fill_viridis_c(option="A", name="Log no. species") + 
  theme(legend.position = c(0.1, 0.8), plot.margin=unit(c(0,-4,0,-0.5),"in"))

heatmap

ggsave("Fig3.pdf", heatmap, units="in", width=8, height=10, dpi=300,
       device="pdf")
