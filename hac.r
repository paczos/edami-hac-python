# rand index, adjusted rand index, jaccard index, silueette coeficient
# different dist functions

hac <- function (data, groupcount, dist=euclid)
{
    # initially: treating each point as a separate cluster
    # using centroids to assess distances between clusters
    # at each step linking clusters that are closest to each other
    colsWithDataCount <- ncol(data);
    ids <- as.integer(rownames(data));
    data$id <- ids;

    data$size <- 1;

    clusterCandidates <- data;
    data$clusterId <- ids;

    while (length(unique(data$clusterId)) > groupcount) {

        s <- combn(1 : nrow(clusterCandidates), 2, function(pair){
            fst = pair[1];
            snd = pair[2];
            distance <- dist(clusterCandidates[fst, 1 : colsWithDataCount], clusterCandidates[snd, 1 : colsWithDataCount]);
            c(fst, snd, distance);
        });
        minimalVecIdx <- which.min(s[3,]);
        fstIdx <- s[1, minimalVecIdx];
        sndIdx <- s[2, minimalVecIdx];
        distance <- s[3, minimalVecIdx];


        fst <- clusterCandidates[fstIdx,]
        snd <- clusterCandidates[sndIdx,]

        fstData = fst[, 1 : colsWithDataCount];
        sndData = snd[, 1 : colsWithDataCount];
        fstClusterSize = fst$size;
        sndClusterSize = snd$size;

        centroidData <- (fstData * fstClusterSize + sndData * sndClusterSize) / (fstClusterSize + sndClusterSize);

        centroidId <- min(fst$id, snd$id);
        data[data$clusterId == fst$id, "clusterId"] = centroidId;
        data[data$clusterId == snd$id, "clusterId"] = centroidId;

        centroidData$id <- centroidId;
        centroidData$size <- fstClusterSize + sndClusterSize;

        # add new row to dataframe
        clusterCandidates <- rbind(clusterCandidates, centroidData);

        # remove merged  clusters from clusterCandidates
        clusterCandidates <- clusterCandidates[- c(fstIdx, sndIdx),];
    }
    data$size <- NULL
    data
}
