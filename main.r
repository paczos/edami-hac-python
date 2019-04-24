#install.packages("cluster.datasets", "microbenchmark")

library(cluster.datasets)
library(datasets)
library(tidyverse)
library(microbenchmark)
library(ggplot2)

options(device = "png")
par()
dev.off()

source("kmeans.r")
source("hac.r")

colnames(iris)

data.noLabels = na.omit(iris %>% select(1 : 4))

hacBenchmark <- microbenchmark(
hac(data.noLabels[c(1 : 10),])
);
print(hacBenchmark) #standard data frame of the output

qplot(y = time, data = hacBenchmark, colour = expr)

kmeansBenchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 3)
);
print(kmeansBenchmark) #standard data frame of the output
qplot(y = time, data = kmeansBenchmark, colour = expr)

