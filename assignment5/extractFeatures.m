function feature_descriptor_matrix = extractFeatures(images, version)
% This function returns features extracted from inputted images. We want/have to
% do this with vl_sift & vl_dsift for gray & rgb & opponent but for now
% lets just stick to vl_sift on gray. The reason I gave the function such a generic
% name is because one of the bonus questions is to extract features other
% than SIFT, which we might want to try (SURF?).

if version == 'gray'
feature_descriptor_matrix = []; 
for n = 1:size(images, 4)   
    image = images(:, :, :, n);
    image = single(rgb2gray(image));
    [f, d] = vl_sift(image); 
    feature_descriptor_matrix = cat(1, feature_descriptor_matrix, d'); % Add feature descriptors extract from this image to the bag of all feature descriptors
end
end

end
