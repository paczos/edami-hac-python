# Data mining: Clustering algorithms implementation and comparison: K-MEANS and HAC – Paweł Paczuski

# Clustering
Clustering is a name of a task of arranging similar objects into groups called `clusters`. Objects in one cluster are closer to each other than objects in another cluster.
The objective of this project is to implement and compare two algorithms that were designed to perform clustering on data: `K-MEANS` and `HAC`

## Centroid-based clustering – K-MEANS
K-MEANS algorithm focuses on finding K points in multidimentional space that will be centers of K clusters to which belong points lying closest to a given point. This way a flat partitioning is obtained. The problem itself is NP-hard in terms of computational complexity, however, the most popular interpretation of the concept behind this algorithm (referred to simply as `K-MEANS`) does not find the optimal solution, but a local maximum. This algorithm places the k points randomly in space and then finds points that are closest to it. Then, a center of a newly formed cluster is calculated – so called `centroid` which is a mean of all points belonging to a cluster. In the next iteration points that are closest to the centroids are found and this operation is repeated until no points change cluster after an iteration. This way a set of clusters is obtained, very often not the best one. In practice, this algorithm is ran several times and the best solution among the ones obtained is selected. This makes the algorithm much more scalable in comparison to the NP-hard optimal algorithm. 

## Hierarchical agglomerative clustering
 
# Assumptions and testing data

# Implementation
## K-MEANS
### Algorithm
### Input
### Output
### Performance
    
## HAC
### Algorithm
### Input

### Output
### Performance

## Comparison


## Summary



