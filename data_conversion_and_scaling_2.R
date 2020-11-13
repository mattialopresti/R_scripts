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
paths <- list.files("R/Tesi Mangolini/Dati XRF/", pattern="*.xlsx", full.names=TRUE)
paths
temp_path <- read.xlsx2(paths[4], sheetIndex = 1, header = TRUE, check.names=FALSE)
filenames <- (gsub(".txt", "",temp_path[,1]))
counter <- nrow(temp_path)
for(i in 1:counter){
    x_variable <- as.numeric(gsub("X", "", colnames(temp_path)))
    newfile <- t(x_variable)
    colnames(newfile) <- x_variable
    y_variable <- temp_path[i,]
    colnames(y_variable) <- x_variable
    newfile <- rbind(newfile, y_variable)
    tbs <- t(newfile)
    write.table(tbs[-1,], file =sprintf("%s.txt",filenames[i]), sep = " ", quote = FALSE, row.names = FALSE, col.names = FALSE)
    rm(x_variable,newfile,y_variable,tbs)
}

