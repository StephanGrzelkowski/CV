% function H, R, C = harris_corner_detector(image, threshold)
image = imread('C:\Users\Sander\Desktop\git\CV\assignment3\person_toy\00000001.jpg');
image = rgb2gray(image);

sobel_x = [1 2 1; 0 0 0; -1 -2 -1];
sobel_y = sobel_x';

Ix = imfilter(image, sobel_x, 'same');
Iy = imfilter(image, sobel_y, 'same');

% subplot(1,3,1);
% imshow(image);
% subplot(1,3,2);
% imshow(Ix);
% subplot(1,3,3);
% imshow(Iy);

A = imgaussfilt(Ix.^2);
B = imgaussfilt(Ix.*Iy);
C = imgaussfilt(Iy.^2);

H = (A .* C - B.^2) - 0.04*(A + C).^2;

% Eerst kijken of het een max is
max_mask = imregionalmax(H);
H_max = H.*uint8(max_mask);

% Daarna thresholden (greater than threshold [0,1])
threshold = 0.9;
thresh_mask = im2bw(H_max, threshold);
H_thresh = H_max .* uint8(thresh_mask);

subplot(1,3,1);
imshow(H);
subplot(1,3,2);
imshow(H_max);
subplot(1,3,3);
imshow(H_thresh);

% end