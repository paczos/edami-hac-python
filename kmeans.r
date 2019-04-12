library("tidyverse")

dist <- function(a, b){
    #    print(paste(a, b, sqrt(sum((a - b) ^ 2))))
    sqrt(sum((a - b) ^ 2))
}

kmeans <- function(data, groupcount)
{
    # using random points from datasets as initial positions for centroids

    centroids <- data[sample(nrow(data), groupcount),];
    clusterIds <- integer(nrow(data));

    while (TRUE) {

        modifiedCluster = 0
        # calculate clusters by finding closest centroid for each point
        for (i in 1 : nrow(data)) {
            row <- data[i,];
            distances <- apply(centroids, 1, function(c){
                dist(c, row)
            })

            # store closest centroid
            #print(distances)
            newClusterId = which.min(distances);
            #print(distances)
            #print(paste(clusterIds[i], newClusterId));

            #Error in if (clusterIds[i] != newClusterId) { :
            # argument is of length zero

            if (clusterIds[i] != newClusterId) {
                clusterIds[i] <- newClusterId;
                modifiedCluster = modifiedCluster + 1 ;
            }
        }

        if (modifiedCluster < 2)
        {
            # if we got here, no item was moved between clusters -> the algorithm had converged
            break
        }
        else {
            print(paste("modified ", modifiedCluster))
        }

        # calculate new centroids
        for (i in 1 : nrow(centroids)) {
            clusterItems = data[clusterIds == i,];
            centroids[i, ] = colMeans(clusterItems);
        }
    }
    data$clusterId = clusterIds;
    data
}

