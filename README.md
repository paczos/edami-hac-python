# Data mining: Clustering algorithms implementation and comparison: K-MEANS and HAC – Paweł Paczuski

# Clustering
Clustering is a name of a task of arranging similar objects into groups called `clusters`. Objects in one cluster are closer to each other than objects in another cluster.
The objective of this project is to implement and compare two algorithms that were designed to perform clustering on data: `K-MEANS` and `HAC`

## Centroid-based clustering – K-MEANS
K-MEANS algorithm focuses on finding K points in multidimentional space that will be centers of K clusters to which belong points lying closest to a given point. This way a flat partitioning is obtained. The problem itself is NP-hard in terms of computational complexity, however, the most popular interpretation of the concept behind this algorithm (referred to simply as `K-MEANS`) does not find the optimal solution, but a local maximum. This algorithm places the k points randomly in space and then finds points that are closest to it. Then, a center of a newly formed cluster is calculated – so called `centroid` which is a mean of all points belonging to a cluster. In the next iteration points that are closest to the centroids are found and this operation is repeated until no points change cluster after an iteration. This way a set of clusters is obtained, very often not the best one. In practice, this algorithm is ran several times and the best solution among the ones obtained is selected. This makes the algorithm much more scalable in comparison to the NP-hard optimal algorithm. 

## Hierarchical agglomerative clustering HAC
Hierarchical agglomerative clustering does not create flat partitioning of data but a hierarchy of clusters. Initially all data-points are treated as singleton clusters. Two points closest to each other are merged into one cluster and a point being a mean of them is used instead of them in the clusters set. Then, merging is repeated until a threshold of "closeness" is crossed or all data-points are connected. Conceptually, a binary tree of connections between data-points is created  – so called `dendrogram`. This may be useful for any tasks that require finding hierarchical structure in flat representation of data-points. HAC is also computationally expensive – `O(n^3)` and also requires O(n^2) memory which makes it impractical for larger data-sets.
  

# Assumptions and testing data
The two algorithms were implemented in R language. This is a dynamic scripting language used mainly for data-science applications. It's strengths lie in wide range of libraries of utilities for data manipulation, data mining and statistics. 
R built-in data-structures are flat and there is no simple notion of a `reference` so in case of HAC implementation, it was necessary to come up with flat representation of a hierarchical results of the algorithm.
For testing purposes, builtin R dataset Iris was used. Data contains 4 dimensional samples describing flowers' Sepals and Petals with label to which species it belongs.

# Implementation
## K-MEANS  

### Algorithm
Centroid-based variant of k-means algorithm was implemented. Distance between points is calculated using simple Euclidean distance. 

### Input
As the input unlabelled data-frame containing data-points in which row is supplied. 

### Output
The algorithm adds new column to the data-frame: `cluster` which stores results of clustering operation.

### Performance


 ![hac 10 data points](https://gitlab.com/paczos/edami-hac-k-means-impl-and-comp/raw/master/Rplot003.png)
 
 
  ![hac 10 data points](https://gitlab.com/paczos/edami-hac-k-means-impl-and-comp/raw/master/Rplot004.png)

    
## HAC

### Algorithm
Algorithm creating complete `dendrogram` of clusters was implemented. Each cluster candidate is represented as a centroid of all points belonging to it. 
The `agglomerative` adjective in the context of hierarchical clustering means that the clustering is performed in a bottom-up way. First we create smaller clusters and then decide how they should be merged to create higher-order clusters containg them.  

### Input
As the input unlabelled data-frame containing data-points in which row is supplied. 

### Output
The algorithm returns a data-frame containing flat representation of a dendrogram. This allows to interpret how the merging of clusters was performed. Each entry in `data` is smallest index number of a row in original data representing cluster.
 
It would be possible to retrieve the full tree structure from this form in O(n) time.

### Performance

 |expr|min|lq|mean|median|uq|max|neval|
 |---|---|---|---|---|---|---|---|
 |hac(data.noLabels[c(1:10), ])| 114.3293| 165.0287| 173.7432| 169.8413| 179.6501|  280.5231 |  100|
 ![hac 10 data points](https://gitlab.com/paczos/edami-hac-k-means-impl-and-comp/raw/master/Rplot001.png)
 
 ![hac 10 data points](https://gitlab.com/paczos/edami-hac-k-means-impl-and-comp/raw/master/Rplot002.png)
## Comparison


## Summary



