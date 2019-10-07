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

%add to the second image on the x so the position reflects the image in the
%stitching
xy_f2(1,:) = xy_f2(1, :) + size(img1, 2);

% plot the images
figure;
imshow(img_stitched./255);
hold on
scatter(xy_f1(1, :), xy_f1(2,:), 'g', 'LineWidth', 2)
scatter(xy_f2(1, :), xy_f2(2,:), 'r', 'LineWidth', 2)
for it = 1 : size(xy_f1, 2)
    line([xy_f1(1, it), xy_f2(1, it)], [xy_f1(2,it), xy_f2(2,it)], 'LineWidth', 2)
end

%% RANSAC (Work in progress)
N = 1000;
P = 10;

transformation = RANSAC(matches, f1, f2, N, P);

new_img = size(img1);
[x,y] = size(img1);
for i = 1:x
    for j = 1:y
        new_cords = round(transformation * [i,j,1]'); 
        new_img(new_cords(1), new_cords(2)) = img1(i, j);
    end
end


