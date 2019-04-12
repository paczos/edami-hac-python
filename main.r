#install.packages("cluster.datasets")

library("cluster.datasets")
library("datasets")
library("tidyverse")

source("kmeans.r")

kmeans(iris %>% select(1 : 4), 3)