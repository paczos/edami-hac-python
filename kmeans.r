library(tidyverse)

dist <- function(a, b){
    sqrt(sum((a - b) ^ 2));
}

kmeans <- function(data, groupcount)
{
    # convergence threshold -> what is the maximal number of items that can be moved between clusters, so that kmeans can stop now
    convTh <- 2

    # using random points from datasets as initial positions for centroids
    centroids <- data[sample(nrow(data), groupcount),];
    clusterIds <- integer(nrow(data));

    while (TRUE) {

        modifiedClusterCount <- 0
        # calculate clusters by finding closest centroid for each point
        for (i in 1 : nrow(data)) {
            row <- data[i,];
            distances <- apply(centroids, 1, function(c){
                dist(c, row);
            })

            # store closest centroid
            newClusterId <- which.min(distances);

            if (clusterIds[i] != newClusterId) {
                clusterIds[i] <- newClusterId;
                modifiedClusterCount <- modifiedClusterCount + 1 ;
            }
        }

        if (modifiedClusterCount < convTh)
        {
            # if we got here, less than convTh items were moved between clusters -> the algorithm had converged
            break
        }
        # else {
        #    print(paste("modified ", modifiedClusterCount))
        # }

        # calculate new centroids
        for (i in 1 : nrow(centroids)) {
            clusterItems <- data[clusterIds == i,];
            centroids[i,] <- colMeans(clusterItems);
        }
    }
    data$clusterId <- clusterIds;
    data
}

