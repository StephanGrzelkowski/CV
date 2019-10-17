function images_histograms = represent_by_histograms(images, visual_dictionary, opt_gray, opt_sift, n_clusters)
% For each of the training images, features are extracted, which are
% subsequently assigned to a visual word in visual_dictionary, allowing us to generate a histogram of visual words per image. Histograms for all inputted images are returned.

images_histograms = [];
for n = 1:size(images, 4)
    cur_image = images(:, :, :, n);
    
    [~,d] = siftOptions(cur_image, opt_gray, opt_sift);
    Idx = knnsearch(double(visual_dictionary'), double(d')); % Assign each descriptor of the image to the nearest visual word and return the index of that visual word
    
    %create edges for number of clusters
    edges = 0 : 1 : n_clusters;
    [counts, ~]= histcounts(Idx, edges);
    
    %normalize counts
    counts = counts ./ sum(counts);
    
    % Create a full histogram representation for the image and add it
    % to the array of histograms, which is returned at the end
    images_histograms = cat(1, images_histograms, counts);
end
end


