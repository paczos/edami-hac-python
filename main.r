#install.packages("cluster.datasets", "microbenchmark")

library(cluster.datasets)
library(datasets)
library(tidyverse)
library(microbenchmark)
library(ggplot2)
library(fossil)
library(clusterCrit)

options(device = "png")
par()
dev.off()

source("kmeans.r")
source("hac.r")


dbgdata.x = c(4, 5, 2, 3, 4, 1, 1, 2)
dbgdata.y = c(5, 5, 4, 3, 4, 1, 2, 1)
dbgdata.cluster = c(1, 1, 1, 1, 1, 2, 2, 2)

dbgdata = data.frame(dbgdata.x, dbgdata.y, dbgdata.cluster)
dbgdata.noLabels = dbgdata %>% select(1 : 2);

dbgdata.kmeans = kmeans(dbgdata.noLabels, 2)
print(dbgdata.kmeans)
print(extCriteria(as.integer(dbgdata.cluster), dbgdata.kmeans$clusterId, c("Rand", "Folkes")))


dbgdata.hac = hac(dbgdata.noLabels, 2)
print(dbgdata.hac)

print(extCriteria(as.integer(dbgdata.cluster), dbgdata.hac$clusterId, c("Rand", "Folkes")))




#iris ds

colnames(iris)
data.noLabels = na.omit(iris %>% select(1 : 4))
res.kmeans3 = kmeans(data.noLabels[c(1 : 10),], 3)
print(res.kmeans3)
print(extCriteria(as.integer(iris[c(1 : 10),]$Species), res.kmeans3$clusterId, c("Rand", "Folkes")))


kmeans.res = kmeans(data.noLabels, 3);
print(extCriteria(as.integer(iris$Species), kmeans.res$clusterId, c("Rand", "Folkes")))


hac.res = hac(data.noLabels[c(1 : 10),], 3);
rand.index(as.numeric(iris[c(1 : 10),]$Species), hac.res$clusterId)
print(extCriteria(as.integer(iris[c(1 : 10),]$Species), kmeans.res$clusterId, c("Rand", "Folkes")))


print(hac(data.noLabels[c(1 : 10),], 3))


# different dist function

mannhattan = function(a, b){
    sum(abs(a - b))
}











hacBenchmark <- microbenchmark(
hac(data.noLabels[c(1 : 10),], 3)
);
print(hacBenchmark)
qplot(y = time, data = hacBenchmark, colour = expr)

hacBenchmarkLarge <- microbenchmark(
hac(data.noLabels[c(1 : 50),], 3)
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
