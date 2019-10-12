function [clusters] = build_visual_vocab(feat_descriptor_matrix, nr_of_clusters)
% This function takes feature descriptors (such as SIFT) and returns visual words in the output called 'clusters': each row
% in the cluster contains a cluster's centroid coordinates(128-D coordinates for SIFT). This output can be used elsewhere to determine which
% feature descriptors of an image belong to which cluster based on
% distances.

% Describe for the input matrix which cluster it belongs to (cluster_idx,
% which we don't use)
% and the centroid of that cluster (clust_centroids)
[cluster_idx, clust_centroids] = kmeans(double(feat_descriptor_matrix), nr_of_clusters); % NB: apparently this Matlab built-in only works if nr_of_clusters is smaller than the amount of data... So this would break if we do 1000 or 4000 clusters or even already at 400... Probably need to implement k-means ourselves.

% initialize output matrix
clusters = zeros(nr_of_clusters, size(feat_descriptor_matrix(1,:), 2)); % initialize output

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

        
    
    
    