dist <- function(a, b){
    sqrt(sum((a - b) ^ 2))
}

hac <- function (data, coohesion)
{
    # initially: treating each point as a separate cluster
    # using centroids to asses distances between clusters
    # at each step linking clusters that are closest to each other

    clusterCandidates <- data;
    connections = []
    # find closest pair
    s <- combn(1 : nrow(clusterCandidates), 2, function(pair){
        fst = pair[1];
        snd = pair[2];
        distance <- dist(clusterCandidates[fst,], clusterCandidates[snd,]);
        c(fst, snd, distance);
    });
    print(s[1,])
    minimalVecIdx <- which.min(s[3,])

    fst <- s[1, minimalVecIdx];
    snd <- s[2, minimalVecIdx];
    distance <- s[3, minimalVecIdx];
    print(paste("idx:", minimalVecIdx, fst, snd, distance));



    # should there be another link placed?
}