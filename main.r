#install.packages("cluster.datasets", "microbenchmark")

library(cluster.datasets)
library(datasets)
library(tidyverse)
library(microbenchmark)
library(ggplot2)
library(fossil)

options(device = "png")
par()
dev.off()

source("kmeans.r")
source("hac.r")


dbgdata.x = c(4,5, 2, 3, 4, 1, 1, 2)
dbgdata.y = c(5,5, 4, 3, 4, 1, 2, 1)
dbgdata.cluster = c(1,1, 1, 1, 1, 2, 2, 2)

dbgdata = data.frame(dbgdata.x, dbgdata.y, dbgdata.cluster)
dbgdata.noLabels = dbgdata %>% select(1 : 2);

dbgdata.kmeans = kmeans(dbgdata.noLabels, 2)
print(dbgdata.kmeans)
print(paste("rand index debug data", rand.index(dbgdata.cluster, dbgdata.kmeans$clusterId)))

dbgdata.hac = hac(dbgdata.noLabels, 2)
print(dbgdata.hac)




colnames(iris)
data.noLabels = na.omit(iris %>% select(1 : 4))
print(kmeans(data.noLabels[c(1 : 10),], 3))

kmeans.res = kmeans(data.noLabels, 3);
rand.index(as.numeric(iris$Species), kmeans.res$clusterId)

hac.res = hac(data.noLabels[c(1 : 10),], 3);
rand.index(as.numeric(iris[c(1 : 10),]$Species), hac.res$clusterId)

print(hac(data.noLabels[c(1 : 10),], 3))

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
