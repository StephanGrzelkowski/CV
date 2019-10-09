function [ stitched ] = stitch(im1,im2, N, P)
[matches, scores, f1, f2] = keypoint_matching(im2, im1);


% Transform right.jpg to align with left
[best_t,best_m] = RANSAC(matches, f1, f2, N, P);
tform = affine2d(best_t');
tformedIm = imwarp(im2, tform, 'nearest'); 


% Calculate the matches between left and tformedIm
[matches, scores, f1, f2] = keypoint_matching(tformedIm, im1);
[best_t,best_m] = RANSAC(matches, f1, f2, N, P);

% Get the coordinates of the matches
xy_subset = f1((1:2) , best_m(1,:));
xy_subset2 = f2((1:2), best_m(2,:));

% calculate the difference between the images in their respective axis
diffx = round(vecnorm(xy_subset(:,1) - xy_subset2(:,1))/2);
diffy = round(vecnorm(xy_subset(:,2) - xy_subset2(:,2))*2)-50;

% Calculate where tformedIm should be overlayed on im1
s1 = size(im1);
s2 = size(tformedIm);
 m = best_t(1:2,1:2);
 t = best_t(3, 1:2);
[width_tformedIm, height_tformedIm] = Whitney(size(im2,1), size(im2,2), m, t);

% Make a new image of the correct size and insert im1 and tformedIm
nn = zeros(size(im1, 1)+width_tformedIm-diffy, size(im1,2)+height_tformedIm-diffx);
nn2 = zeros(size(im1, 1)+width_tformedIm-diffy, size(im1,2)+height_tformedIm-diffx);

nn(1:s1(1),1:s1(2)) = im1;

%create a second image with the same size 
nn2(1:s1(1),1:s1(2)) = im1;
nn2(1:s1(1),1:s1(2)) = 0;
nn2(1+s1(1)-diffy: s1(1)-diffy+s2(1), s1(2) - diffx+1:  s1(2) - diffx+s2(2))= tformedIm;

%find the non-zero entries
idcs_clear = find(nn2);
%fill the stitched image with the rotated image where that one is not 0
nn(idcs_clear) = nn2(idcs_clear);

%fix the right edge 
vec_col = ones(size(nn, 1), 1);
cur_col = 1;
%loop through columns until there is one that has pure 0's 
while sum(vec_col) > 0 
    vec_col = nn(:, cur_col);
    cur_col = cur_col + 1; 
end
%remove 0 columns on the right side
nn = nn(:, 1 : cur_col-1); 

stitched = nn;

end
