function visualize(input_image, name_colorspace)
%{
 This function plots either:
I. the result of different rgb2grayscale conversions  
OR
ii. (a) an image converted to 
 Opponent Color Space
 OR rgb Color Space
 OR HSV Color Space
 OR YCbCr Color Space
 + (b) the separate channels
%}

if strcmp(name_colorspace, 'gray')
    for image_number = 1:size(input_image, 4)           
        subplot(floor((size(input_image, 4))/2), ceil((size(input_image, 4))/2), image_number), imshow(input_image(:,:,:,image_number));
        title(join([name_colorspace, ': method ', num2str(image_number)], ','));
    end
    
else 
    % First plot the converted image...
    subplot(floor((size(input_image, 3)+1)/2), ceil((size(input_image, 3)+1)/2), 1), imshow(input_image);  
    title(name_colorspace);
    for image_number = 2:size(input_image, 3)+1;        % , and then plot the channels of that new image.
        subplot(floor((size(input_image, 3)+1)/2), ceil((size(input_image, 3)+1)/2), image_number), imshow(input_image(:,:,image_number-1));
        title(join([name_colorspace, ': channel ', num2str(image_number-1)], ',')); 
    end
end   
end

