function images_histograms = represent_by_histograms(images, visual_dictionary, version)
% For each of the training images, features are extracted, which are
% subsequently assigned to a visual word in visual_dictionary, allowing us to generate a histogram of visual words per image. Histograms for all inputted images are returned. 
if version == 'gray' 
    images_histograms = [];
    for n = 1:size(images, 4)   
        image = images(:, :, :, n); 
        image = single(rgb2gray(image));
        [f, d] = vl_sift(image);  
        if size(d, 2) == 0 % Discard the image if no feature descriptors were extracted
            continue
        end
        Idx = knnsearch(visual_dictionary, d'); % Assign each descriptor of the image to the nearest visual word and return the index of that visual word 
     
        histogram = histcounts(Idx); 
        % This histogram starts with the smallest bin, the smallest
        % ocurring visual word index, which might not be visual word #1.
        % Similarly, the histogram also ends at the largest bin, largest occuring
        % visual word index, which might not be the last visual word in the
        % dictionary. Hence, we pad with zeros as per below:        
        amount_front_padding = min(Idx)-1;
        front_padding = zeros(1, amount_front_padding);
        amount_back_padding = size(visual_dictionary, 1)-max(Idx);
        back_padding = zeros(1, amount_back_padding);

        % Create a full histogram representation for the image and add it
        % to the array of histograms, which is returned at the end
        image_histogram_representation = [front_padding histogram back_padding];
        images_histograms = cat(1, images_histograms, image_histogram_representation);
    end
end
end

     