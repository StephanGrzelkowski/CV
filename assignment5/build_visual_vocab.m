function [clust_centroids] = build_visual_vocab(feat_descriptor_matrix, nr_of_clusters)
% This function takes feature descriptors (such as SIFT) and returns visual words in the output called 'clusters': each row
% in the cluster contains a cluster's centroid coordinates(128-D coordinates for SIFT). This output can be used elsewhere to determine which
% feature descriptors of an image belong to which cluster based on
% distances.

% Describe for the input matrix which cluster it belongs to (cluster_idx,
% which we don't need)
% and the centroid of that cluster (clust_centroids)
[clust_centroids, idx_clust] = kmeans(double(feat_descriptor_matrix)', nr_of_clusters); % NB: apparently this Matlab built-in only works if nr_of_clusters is smaller than the amount of data... So this would break if we do 1000 or 4000 clusters or even already at 400... Probably need to implement k-means ourselves.

end

        
    
    
    