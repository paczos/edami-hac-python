#install.packages("cluster.datasets")

library("cluster.datasets")
library("datasets")
library("tidyverse")

source("kmeans.r")
colnames(iris)
kmeans(iris %>% select(1 : 4), 3)