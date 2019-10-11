function [clusters] = build_visual_vocab(feat_descriptor_matrix, nr_of_clusters)
% This function returns visual words in the form of 'clusters'): each row
% in the cluster contains the cluster centroid coordinates (in our
% assignment 128-D coordinates). This output can be used to determine which
% feature descriptors of an image belong to which cluster based on
% distances.

% Describe for the input matrix which cluster it belongs to (cluster_idx,
% which we don't use)
% and the centroid of that cluster (clust_centroids)
[cluster_idx, clust_centroids] = kmeans(feat_descriptor_matrix, nr_of_clusters);

% initialize output matrix
clusters = zeros(nr_of_clusters, 128) % initialize output

% Loop over all the feature descriptors' cluster centroid
for i = 1:size(clust_centroids)
   
    % check if that feature descriptor's cluster centroid has already been added to
    % the output ...
    is_redundantindex = 0;
    for existing_cluster_centroid = 1:nr_of_clusters
        if clust_centroids(i) == clusters(existing_cluster_centroid, :);
            is_redundantindex = 1;
        end
    end
            
    if is_redundantindex == 0;
        % ... if not, add the cluster centroid coordinates to the output matrix
        clusters(i, :) = clust_centroids(i);
    end
    
end

        
    
    
    