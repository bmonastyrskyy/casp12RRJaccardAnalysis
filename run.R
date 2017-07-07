# Project : CASP12 RR predictions similarity analysis
# Author : Bohdan Monastyrskyy
# Date : 2017-07-07
# Description : the R script generates heat maps based on Jaccard distance 
#               between sets of predicted contacts

# load libraries
if (!require("rjson")){
  install.packages('rjson');
  require('gplots')
}
if (!require('gplots')){
  install.packages('gplots');
  require('gplots')
}
if (!require('viridis')){
  install.packages("viridis");
  require('viridis')
}

# read files
fs <- list.files("./data", pattern = "T*txt")


for (f in fs){
  # read data in json format
  df <- fromJSON(file = paste0("data/", f))
  # transform to matrix
  m <- as.matrix(sapply(df, function(x){unlist(x)}))
  ft <- gsub(".txt", ".tiff", f)
  tiff(paste0("./plots/",ft), res = 72, compression = "lzw", width = 720, height = 720);
  heatmap.2(m, symm=TRUE, tracecol="gray",
            trace="none", hclustfun = function(x) hclust(x,method = 'single'),
            density.info="none", dendrogram = 'both', key = TRUE, key.xlab = "",
            col = "plasma", key.title = "", keysize = 0.75,
            key.xtickfun = function(){return(list(labels=c("0.0", "0.5", "1.0"), at=c(0.0, 0.5, 1.0)))},
            margins =c(5,5))
  dev.off()
  f.png <- gsub(".txt", ".png", f)
  png(paste0("./plots/",f.png), res = 72, width = 720, height = 720)
  heatmap.2(m, symm=TRUE, tracecol="gray",
            trace="none", hclustfun = function(x) hclust(x,method = 'single'),
            density.info="none", dendrogram = 'both', key = TRUE, key.xlab = "",
            col = "plasma", key.title = "", keysize = 1.0,
            key.xtickfun = function(){return(list(labels=c("0.0", "0.5", "1.0"), at=c(0.0, 0.5, 1.0)))},
            margins =c(5,5))
  dev.off()
  f.pdf <- gsub(".txt", ".pdf", f)
  pdf(paste0("./plots/",f.pdf),width=6,height=6,paper='special')
  heatmap.2(m, symm=TRUE, tracecol="gray",
            trace="none", hclustfun = function(x) hclust(x,method = 'single'), 
            density.info="none", dendrogram = 'both', key = TRUE, key.xlab = "",
            col = "plasma", key.title = "", keysize = 1.5, 
            key.xtickfun = function(){return(list(labels=c("0.0", "0.5", "1.0"), at=c(0.0, 0.5, 1.0)))},
            margins =c(5,5))
  dev.off()
  
}
