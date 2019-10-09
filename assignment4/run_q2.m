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

a=stitch(img1,img2);
figure;
imshow(uint8(a))
hold on