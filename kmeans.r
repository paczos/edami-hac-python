library("tidyverse")

dist <- function(a, b){
    sqrt(sum((a - b) ^ 2))
}

kmeans <- function(data, groupcount)
{
    # using random points from datasets as initial positions for centroids
    data$clusterId <- 0;

    centroids <- data[sample(nrow(data), groupcount),]

    while (TRUE) {

        modifiedCluster = FALSE
        # calculate clusters by finding closest centroid for each point
        for (i in 1 : nrow(data)) {
            row <- data[i,];
            distances <- apply(centroids, 1, function(c){
                # TODO remove columns with clusterId before calculating dist
                dist(c, row)
            })

            # store closest centroid
            newClusterId = which.min(distances);
            if (row$clusterId != newClusterId) {
                data[i,]$clusterId <- newClusterId;
                modifiedCluster <- TRUE
            }
        }

        if (modifiedCluster == FALSE)
        {
            break
        }

        # TODO calculate new centroids


    }
    print(data)
}

