close all

% run('C:\Users\Sander\Desktop\git\CV\assignment4\vlfeat-0.9.21\toolbox\vl_setup');

%% load images
img1 = single(imread('boat1.pgm'));
img2 = single(imread('boat2.pgm'));

%% do keypoint matching
[matches, scores, f1, f2] = keypoint_matching(img1, img2);

%select a random number of points to plot
idcs_rand = randi(length(scores), 10, 1); 

%stitch the image columns for visualization;
img_stitched = [img1 , img2];

%get the position of the feature points
xy_f1 = f1(1:2, matches(1, idcs_rand));
xy_f2 = f2(1:2, matches(2, idcs_rand)); 

%add to the second image on the x so the position reflects the image in the stitching
xy_f2(1,:) = xy_f2(1, :) + size(img1, 2);

% plot the randomly chosen matching points between boat1 and boat2
figure;
imshow(img_stitched./255);
hold on
scatter(xy_f1(1, :), xy_f1(2,:), 'g', 'LineWidth', 2)
scatter(xy_f2(1, :), xy_f2(2,:), 'r', 'LineWidth', 2)
for it = 1 : size(xy_f1, 2)
    line([xy_f1(1, it), xy_f2(1, it)], [xy_f1(2,it), xy_f2(2,it)], 'LineWidth', 2)
end 
%% RANSAC
N = 10;
P = 10;

best_params = RANSAC(matches, f1, f2, N, P, img_stitched);

% I) visualize transformation from using matlab's built-in function imwarp
tform = affine2d(best_params');
transform_img = imwarp(img1, tform, 'nearest');
figure;
imshow(uint8(transform_img));

% II) visualize transformation from using our own implementated affine function
transform_img1 = affine(img1, best_params'); % transform the source image
transform_img2 = affine(img2, best_params'); % transform the target image (equivalent to transforming the source image twice)
figure;

subplot(1,2,1);
imshow(uint8(transform_img1));

subplot(1,2,2);
imshow(uint8(transform_img2));

