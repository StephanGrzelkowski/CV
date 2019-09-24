function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
image = im2double(image);
[k, l] = size(image);
im_magnitude = zeros(k, l);
im_direction = zeros(k, l);

% Convolute the images with the x and y kernels
x = [1 0 -1; 2 0 -2; 1 0 -1];
y = [1 2 1; 0 0 0; -1 -2 -1];
Gx = imfilter(image, x, 'replicate', 'same');
Gy = imfilter(image, y, 'replicate', 'same');

% For each pixel, calculate the magnitude and direction
for i = 1:k
    for j = 1:l
        im_magnitude(i,j) = sqrt(Gx(i,j)^2 + Gy(i,j)^2);
        im_direction(i,j) = atan(Gx(i,j) / Gy(i,j));
    end
end

% Plot the images
subplot(2, 3, 1);
imshow(image);
subplot(2, 3, 2);
imshow(Gx);
subplot(2, 3, 3);
imshow(Gy);
subplot(2, 3, 4);
imshow(im_magnitude);
subplot(2, 3, 5)
imshow(im_direction);

% imwrite(uint8(Gx), 'Q8_gx.png');
% imwrite(uint8(Gy), 'Q8_gy.png');
% imwrite(im_magnitude, 'Q8_mag.png');
% imwrite(im_direction, 'Q8_dir.png');

end

