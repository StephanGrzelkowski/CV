%% load images
img1 = single(imread('boat1.pgm'));
img2 = single(imread('boat2.pgm'));



%% do keypoint matching
[matches, scores] = keypoint_matching(img1, img2)