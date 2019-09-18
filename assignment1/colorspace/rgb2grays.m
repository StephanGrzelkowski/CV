function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[R, G, B] = getColorChannels(input_image);

% ligtness method
output_image1 = (max(max(R, G), B) + min(min(R, G), B)) / 2;

% average method
output_image2 = (R+G+B)/3; 

% luminosity method
output_image3 = 0.21*R + 0.72*G + 0.07*B; 

% built-in MATLAB function 
output_image4 = rgb2gray(input_image); 

output_image = cat(4, output_image1, output_image2, output_image3, output_image4); % There is probably a smarter way to go about this, but this does the job for now
end

