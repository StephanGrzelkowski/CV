image_toy = imread('.\person_toy\00000001.jpg');
image_pingpong = imread('.\pingpong\0000.jpeg');

% Toy person image
kernel_size = 5;
sigma = 1;

% threshold = 1;
% [H, r, c] = harris_corner_detector(image_toy, kernel_size, sigma, threshold);
% pause(1)
threshold = 10;
[H, r, c] = harris_corner_detector(image_toy, kernel_size, sigma, threshold);
pause(1)
% threshold = 100;
% [H, r, c] = harris_corner_detector(image_toy, kernel_size, sigma, threshold);
% pause(1)

% Pingpong image
% threshold = 1;
% [H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);
% pause(1)
threshold = 10;
[H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);
pause(1)
% threshold = 100;
% [H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);
% pause(1)

% Testing rotation-invariant
threshold = 10;
image_toy_45 = imrotate(image_toy, 45);
[H, r, c] = harris_corner_detector(image_toy_45, kernel_size, sigma, threshold);
pause(1)
image_toy_90 = imrotate(image_toy, 90);
[H, r, c] = harris_corner_detector(image_toy_90, kernel_size, sigma, threshold);