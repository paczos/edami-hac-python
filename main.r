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

kmeans3Benchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 3)
);
print(kmeans3Benchmark) #standard data frame of the output
qplot(y = time, data = kmeans3Benchmark, colour = expr)


kmeans10Benchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 10)
);
print(kmeans10Benchmark) #standard data frame of the output
qplot(y = time, data = kmeans10Benchmark, colour = expr)
