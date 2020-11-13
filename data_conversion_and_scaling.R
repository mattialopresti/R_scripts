# LOADING LIBRARIES AND SETTING UP ENVIRONMENT ----
options(java.parameters = "-Xmx15360m")
library(ape)
library(ggplot2)
library(xlsx)
library(dplyr)
library(RcppArmadillo)
library(tidyr)
library(prospectr)
library(corrplot)
library(stringr)
theme_mattia <- theme(panel.background = element_rect(fill = "white"),
                      panel.border = element_rect(colour = "black", size = 0.2, fill = NA),
                      axis.title.x = element_text(size = 18, margin = margin(10,0,0,0)),
                      axis.title.y = element_text(size = 18, margin = margin(0,10,0,0)),
                      plot.title = element_text(size = 28, hjust = 0.5),
                      panel.spacing = unit(0, "lines"),
                      legend.position = c(0.1, 0.80),
                      panel.grid.minor = element_line(linetype = 3, colour = "#dcdcdc"),
                      panel.grid.major = element_line(linetype = 2, colour = "#cbcbcb")
)



# READ DIRECTORY LOOKING FOR XLSX FILES. OPEN AND COMBINE THEM IN A DATA MATRIX ----
paths <- list.files("R/doe_4comp_bea/", pattern="*.xy", full.names=TRUE)
filenames <- list.files("R/doe_4comp_bea/", pattern="*.xy", full.names=FALSE)
temp_path <- read.delim(paths[1], sep = "")
temp_path <- as.numeric(as.character(temp_path[,1]))
data_matrix <- t(temp_path)
data_matrix_derived <- data_matrix[5:ncol(data_matrix)] # SAVITZKY-GOLAY FILTERING STEALS 4 VARS
temp_path <- savitzkyGolay(temp_path, m = 0, p = 2, w = 5) 
data_matrix_derived <- rbind(temp_path, data_matrix_derived)
data_matrix_derived <- data_matrix_derived[-2,]
for(i in 1:length(filenames)){
  temp <- read.delim(paths[i], sep = "")
  temp <- as.numeric(as.character(temp[,2]))
  data_matrix <- rbind(data_matrix, temp)
  data_matrix_derived <- rbind(data_matrix_derived, savitzkyGolay(temp, m = 1, p = 2, w = 5))
}
colnames(data_matrix) <- data_matrix[1,]
colnames(data_matrix_derived) <- data_matrix_derived[1,]
data_matrix <- data_matrix[-1,]
data_matrix_derived <- data_matrix_derived[-1,]
rownames(data_matrix) <- filenames
rownames(data_matrix_derived) <- filenames
data_matrix_scaled <- scale(data_matrix, center = TRUE, scale = TRUE)
data_matrix_derived_scaled <- scale(data_matrix_derived, center = TRUE, scale = TRUE)

write.xlsx(data_matrix, "R/doe_4comp_bea/data_matrix.xlsx") #WRITE DATA MATRIX DISABLED; USED IT ONLY IF NECESSARY.
write.xlsx(data_matrix_derived, "R/doe_4comp_bea/data_matrix_derived.xlsx") #WRITE DATA MATRIX DISABLED; USED IT ONLY IF NECESSARY.
write.xlsx(data_matrix_scaled, "R/doe_4comp_bea/data_matrix_scaled.xlsx") #WRITE DATA MATRIX DISABLED; USED IT ONLY IF NECESSARY.
write.xlsx(data_matrix_derived_scaled, "R/doe_4comp_bea/data_matrix_derived_scaled.xlsx") #WRITE DATA MATRIX DISABLED; USED IT ONLY IF NECESSARY.
