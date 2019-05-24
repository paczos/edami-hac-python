#install.packages("cluster.datasets", "microbenchmark")

library(cluster.datasets)
library(datasets)
library(tidyverse)
library(microbenchmark)
library(ggplot2)
library(fossil)
library(clusterCrit)
library(cluster)

options(device = "png")
par()
dev.off()

source("kmeans.r")
source("hac.r")

euclid <- function(a, b){
    sqrt(sum((a - b) ^ 2));
}

dbgdata.x = c(4, 5, 2, 3, 4, 1, 1, 2)
dbgdata.y = c(5, 5, 4, 3, 4, 1, 2, 1)
dbgdata.cluster = c(1, 1, 1, 1, 1, 2, 2, 2)

dbgdata = data.frame(dbgdata.x, dbgdata.y, dbgdata.cluster)
dbgdata.noLabels = dbgdata %>% select(1 : 2);

dbgdata.kmeans = kmeans(dbgdata.noLabels, 2, euclid)
print(dbgdata.kmeans)
print(extCriteria(as.integer(dbgdata.cluster), dbgdata.kmeans$clusterId, c("Rand", "Folkes")))

distM <- dist(dbgdata)
plot(silhouette(dbgdata.kmeans$clusterId, distM))




dbgdata.hac = hac(dbgdata.noLabels, 2, euclid)
print(dbgdata.hac)

print(extCriteria(as.integer(dbgdata.cluster), dbgdata.hac$clusterId, c("Rand", "Folkes")))
distM <- dist(dbgdata)
plot(silhouette(dbgdata.hac$clusterId, distM))



#iris ds

colnames(iris)
data.noLabels = na.omit(iris %>% select(1 : 4))
res.kmeans3 = kmeans(data.noLabels[c(1 : 50),], 3, euclid)


print(res.kmeans3)
print(extCriteria(as.integer(iris[c(1 : 50),]$Species), res.kmeans3$clusterId, c("Rand", "Folkes")))
distM <- dist(iris[c(1 : 50),])
plot(silhouette(res.kmeans3$clusterId, distM))

kmeans.res = kmeans(data.noLabels, 3, euclid);
print(extCriteria(as.integer(iris$Species), kmeans.res$clusterId, c("Rand", "Folkes")))
distM <- dist(data.noLabels)
plot(silhouette(kmeans.res$clusterId, distM))

hac.res = hac(data.noLabels[c(1 : 50),], 3, euclid);
rand.index(as.numeric(iris[c(1 : 50),]$Species), hac.res$clusterId)
print(extCriteria(as.integer(iris[c(1 : 50),]$Species), hac.res$clusterId, c("Rand", "Folkes")))
distM <- dist(data.noLabels[c(1 : 50),])
plot(silhouette(hac.res$clusterId, distM))



print(hac(data.noLabels[c(1 : 10),], 3))
print(extCriteria(as.integer(iris[c(1 : 100),]$Species), hac(data.noLabels[c(1 : 10),], 3)$clusterId, c("Rand", "Folkes")))

# different dist function
print("mannhattan")
mannhattan = function(a, b){
    sum(abs(a - b))
}

dbgdata.kmeans.man = kmeans(dbgdata.noLabels, 2, mannhattan)
print(dbgdata.kmeans.man)
print(extCriteria(as.integer(dbgdata.cluster), dbgdata.kmeans.man$clusterId, c("Rand", "Folkes")))


dbgdata.hac.man = hac(dbgdata.noLabels, 2, mannhattan)
print(dbgdata.hac.man)

print(extCriteria(as.integer(dbgdata.cluster), dbgdata.hac.man$clusterId, c("Rand", "Folkes")))



colnames(iris)
data.noLabels = na.omit(iris %>% select(1 : 4))
res.kmeans3.man = kmeans(data.noLabels[c(1 : 10),], 3, mannhattan)
print(res.kmeans3.man)
print(extCriteria(as.integer(iris[c(1 : 10),]$Species), res.kmeans3.man$clusterId, c("Rand", "Folkes")))


kmeans.res.man = kmeans(data.noLabels, 3, mannhattan);
print(extCriteria(as.integer(iris$Species), kmeans.res.man$clusterId, c("Rand", "Folkes")))


hac.res.man = hac(iris[c(1 : 10),]$Species, 3, mannhattan);
print(extCriteria(as.integer(iris[c(1 : 10),]$Species), hac.res.man$clusterId, c("Rand", "Folkes")))





# benchmarking

hacBenchmark <- microbenchmark(
hac(data.noLabels[c(1 : 10),], 3, euclid)
);
print(hacBenchmark)
qplot(y = time, data = hacBenchmark, colour = expr)

hacBenchmarkLarge <- microbenchmark(
hac(data.noLabels[c(1 : 50),], 3, euclid)
);
print(hacBenchmarkLarge)
qplot(y = time, data = hacBenchmarkLarge, colour = expr)


kmeans3Benchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 3, euclid)
);
print(kmeans3Benchmark)
qplot(y = time, data = kmeans3Benchmark, colour = expr)

kmeans3BenchmarkLarge <- microbenchmark(
kmeans(data.noLabels[c(1 : 50),], 3, euclid)
);
print(kmeans3BenchmarkLarge)
qplot(y = time, data = kmeans3BenchmarkLarge, colour = expr)


kmeans10Benchmark <- microbenchmark(
kmeans(data.noLabels[c(1 : 10),], 10, euclid)
);
print(kmeans10Benchmark)
qplot(y = time, data = kmeans10Benchmark, colour = expr)

kmeans10BenchmarkLarge <- microbenchmark(
kmeans(data.noLabels[c(1 : 50),], 10, euclid)
);
print(kmeans10BenchmarkLarge)
qplot(y = time, data = kmeans10BenchmarkLarge, colour = expr)
