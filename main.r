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
print(kmeans(data.noLabels[c(1 : 10),], 3))
print(hac(data.noLabels[c(1 : 10),]))

hacBenchmark <- microbenchmark(
hac(data.noLabels[c(1 : 10),])
);
print(hacBenchmark)
qplot(y = time, data = hacBenchmark, colour = expr)

hacBenchmarkLarge <- microbenchmark(
hac(data.noLabels[c(1 : 50),])
);
print(hacBenchmarkLarge)
qplot(y = time, data = hacBenchmarkLarge, colour = expr)


kmeans3Benchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 3)
);
print(kmeans3Benchmark)
qplot(y = time, data = kmeans3Benchmark, colour = expr)

kmeans3BenchmarkLarge <- microbenchmark(
kmeans(data.noLabels[c(1 : 50),], 3)
);
print(kmeans3BenchmarkLarge)
qplot(y = time, data = kmeans3BenchmarkLarge, colour = expr)


kmeans10Benchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 10)
);
print(kmeans10Benchmark)
qplot(y = time, data = kmeans10Benchmark, colour = expr)

kmeans10BenchmarkLarge <- microbenchmark(
kmeans(data.noLabels[c(1 : 50),], 10)
);
print(kmeans10BenchmarkLarge)
qplot(y = time, data = kmeans10BenchmarkLarge, colour = expr)
