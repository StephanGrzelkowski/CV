close all

%% load images
img1 = single(rgb2gray(imread('left.jpg')));
img2 = single(rgb2gray(imread('right.jpg')));

% figure
% imshow(uint8(img1))
% hold on
% 
% figure
% imshow(uint8(img2))
% hold on

[matches, scores, f1, f2] = keypoint_matching(img1, img2);
N = 10;
P = 10;
best_t = RANSAC(matches, f1, f2, N, P, img1);