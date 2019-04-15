#install.packages("cluster.datasets")

library("cluster.datasets")
library("datasets")
library("tidyverse")

source("kmeans.r")
source("hac.r")

colnames(iris)
data.noLabels = iris %>% select(1 : 4)

kmeans(data.noLabels, 3)
hac(data.noLabels)