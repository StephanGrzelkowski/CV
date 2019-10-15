function feature_descriptor_matrix = extractFeatures(images,opt_gray, opt_sift)
% This function returns features extracted from inputted images. We want/have to
% do this with vl_sift & vl_dsift for gray & rgb & opponent but for now
% lets just stick to vl_sift on gray. The reason I gave the function such a generic
% name is because one of the bonus questions is to extract features other
% than SIFT, which we might want to try (SURF?).

feature_descriptor_matrix = []; 
for n = 1:size(images, 4)   
    %get current image
    cur_image = images(:, :, :, n);
    
    %do the sift
    [~,d] = siftOptions(cur_image, opt_gray, opt_sift); 

    %append to feature matrix
    feature_descriptor_matrix = cat(1, feature_descriptor_matrix, d'); % Add feature descriptors extracted from this image to the bag of all feature descriptors
end

end


