image_toy = imread('.\person_toy\00000001.jpg');
image_pingpong = imread('.\pingpong\0000.jpeg');

% Toy person image
kernel_size = 7;
sigma = 1;
threshold = 1;
[H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);
% pause(0.01);
% threshold = 10;
% [H, r, c] = harris_corner_detector(image_toy, kernel_size, sigma, threshold);
% pause(0.01);
% threshold = 100;
% [H, r, c] = harris_corner_detector(image_toy, kernel_size, sigma, threshold);
% 
% % Pingpong image
% threshold = 1;
% [H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);
% pause(0.01);
% threshold = 10;
% [H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);
% pause(0.01);
% threshold = 100;
% [H, r, c] = harris_corner_detector(image_pingpong, kernel_size, sigma, threshold);