close all

% read the images
img1 = single(rgb2gray(imread('left.jpg')));
img2 = single(rgb2gray(imread('right.jpg')));

% throw them in the stitch function and display the result
a=stitch(img1,img2);
figure;
imshow(uint8(a))
hold on
