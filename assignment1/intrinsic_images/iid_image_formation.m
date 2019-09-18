
% Read given images
original = imread('ball.png');
albedo = imread('ball_albedo.png');
shading = imread('ball_shading.png');

% Reconstruct the image with the given intrinsic components
reconstr = double(shading) .* double(albedo); % Force the product to be 16-bits and not 8

% Plot all given figs + the reconstruction
subplot(2, 2, 1), imshow(original) 
subplot(2, 2, 2), imshow(albedo)
subplot(2, 2, 3), imshow(shading) 
subplot(2, 2, 4), imshow(uint16(reconstr)) 
