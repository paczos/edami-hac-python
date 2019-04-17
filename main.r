#install.packages("cluster.datasets")

library("cluster.datasets")
library("datasets")
library("tidyverse")

source("kmeans.r")
source("hac.r")

colnames(iris)
data.noLabels = na.omit(iris %>% select(1 : 4))
hac(data.noLabels[c(1 : 10),])
kmeans(data.noLabels[c(1 : 10),], 3)
