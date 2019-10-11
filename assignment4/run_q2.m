close all

% read the images
img1 = single(rgb2gray(imread('left.jpg')));
img2 = single(rgb2gray(imread('right.jpg')));

% figure
% imshow(uint8(img1))
% hold on
% 
% figure
% imshow(uint8(img2))
% hold on

%number of iterations for ransac
N = 30; 
%number of points for ransac
P = 10; 
a=stitch(img1,img2, N, P);

figure;
imshow(uint8(a))
hold on
