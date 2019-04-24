dist <- function(a, b){
    sqrt(sum((a - b) ^ 2));
}

hac <- function (data)
{
    # initially: treating each point as a separate cluster
    # using centroids to assess distances between clusters
    # at each step linking clusters that are closest to each other
    colsWithDataCount <- ncol(data);
    ids <- as.integer(rownames(data));
    data$id <- ids;
    data$size <- 1;

    clusterCandidates <- data;

    clusters <- data.frame(data = integer(), cluster = integer());

    while (nrow(clusterCandidates) > 1) {

        # print(paste("clusters", nrow(clusters)));

        # find closest pair
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
        # print(paste(fstClusterSize, sndClusterSize))

        centroidData <- (fstData * fstClusterSize + sndData * sndClusterSize) / (fstClusterSize + sndClusterSize);
        centroidId <- min(fst$id, snd$id);
        centroidData$id <- centroidId;
        centroidData$size <- fstClusterSize + sndClusterSize;

        # add new row to dataframe
        clusterCandidates <- rbind(clusterCandidates, centroidData);
        # remove merged  clusters from clusterCandidates
        clusterCandidates <- clusterCandidates[- c(fstIdx, sndIdx),];

        newClusterId <- nrow(clusters) + 1;

        clusters <- rbind(clusters, list(data = fst$id, cluster = newClusterId));
        clusters <- rbind(clusters, list(data = snd$id, cluster = newClusterId));
    }

    clusters
}
