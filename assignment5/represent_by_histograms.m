function images_histograms = represent_by_histograms(images, visual_dictionary, version)
% For each of the training images, features are extracted, which are
% subsequently assigned to a visual word in visual_dictionary, allowing us to generate a histogram of visual words per image. Histograms for all inputted images are returned. 

n_clusters = 40;
if strcmp(version,  'gray')
    images_histograms = [];
    for n = 1:size(images, 4)   
        image = images(:, :, :, n); 
        image = single(rgb2gray(image));
        [~, d] = vl_sift(image);  
        if size(d, 2) == 0 % Discard the image if no feature descriptors were extracted
            continue
        end
        Idx = knnsearch(visual_dictionary', d'); % Assign each descriptor of the image to the nearest visual word and return the index of that visual word 
        edges = 0 : 1 : n_clusters;
        [counts, edges]= histcounts(Idx, edges); 

        % Create a full histogram representation for the image and add it
        % to the array of histograms, which is returned at the end
        images_histograms = cat(1, images_histograms, counts);
    end
end
end

     