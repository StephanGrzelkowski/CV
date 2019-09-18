% Read given images
original = imread('ball.png');
albedo = imread('ball_albedo.png');
shading = imread('ball_shading.png');

% Recolor the ball
copy = albedo;

copy(copy==184) = 0;
copy(copy==141) = 255;
copy(copy==108) = 0;

% Reconstruct the ball with recolored albedo and the given shading
reconstruction = double(copy) .* double(shading);

% Plot the original ball and the recolored ball
subplot(1,2,1), imshow(original);
subplot(1,2,2), imshow(uint16(reconstruction));








%{
new = original;

new(:,:,1) = zeros(size(new, 1), size(new, 2));
new(:,:,2) = ones(size(new, 1), size(new, 2))*255;
new(:,:,3) = zeros(size(new, 1), size(new, 2));
 

subplot(2,1,1), imshow(new);

 %}

