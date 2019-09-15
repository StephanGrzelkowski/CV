function visualize(input_image, name_colorspace, savefig)
%{
 This function plots either:
I. (a) an image converted to 
 Opponent Color Space
 OR rgb Color Space
 OR HSV Color Space
 OR YCbCr Color Space
 + (b) the separate channels
OR
II. Different rgb2grayscale conversions  
%}

size(input_image)                                       % just for own reference 

if strcmp(name_colorspace, 'gray')
    % Plot all rgb to grayscale conversions:
    for image_number = 1:size(input_image, 4)           
        subplot(floor((size(input_image, 4))/2), ceil((size(input_image, 4))/2), image_number), imshow(input_image(:,:,:,image_number));
        title(join([name_colorspace, ': method ', num2str(image_number)], ','));
    end
    
else 
    % Plot the new image and its channels:
    subplot(floor((size(input_image, 3)+1)/2), ceil((size(input_image, 3)+1)/2), 1), imshow(input_image); % First plot the 'whole' image...
    title(name_colorspace);
    for image_number = 2:size(input_image, 3)+1;        % , then plot the channels of the whole image.
        subplot(floor((size(input_image, 3)+1)/2), ceil((size(input_image, 3)+1)/2), image_number), imshow(input_image(:,:,image_number-1));
        title(join([name_colorspace, ': channel ', num2str(image_number-1)], ',')); 
    end
end   

if savefig == true
    saveas(gcf, join([name_colorspace, '.png'], ','))
end
end

