%% load images
img1 = single(imread('boat1.pgm'));
img2 = single(imread('boat2.pgm'));



%% do keypoint matching 
%do sift n each image
[f1,d1] = vl_sift(img1);
[f2,d2] = vl_sift(img2);

%keypoint matching
[matches, scores] = vl_ubcmatch(d1, d2);
%% ransac
N=2
P = 10
 
for iteration = 1:N 
    random_subset = randperm(size(matches, 2), P);
    columns = matches(:, random_subset);
    xa_all = f1(1, columns);

    xb_all = f2(1, columns);

    ya_all = f1(2, columns);

    yb_all = f2(2,  columns);
    
    for i = 1:P
        A = [xa_all(i) ya_all(i) 0 0 1 0; 0 0 xa_all(i) ya_all(i) 0 1];
        b = [xb_all(i); yb_all(i)];
        x = pinv(A)*b;  % compute x, the transformation params
    end
    ms = x'(:4).reshape(2,2)
    ts = x'(5:)
     
   
    transformed_im1 = ms * [xa_all; ya_all] + ts
    
    % Plot sth, but not sure yet what. TODO: find out
    subplot(2,1,1), imshow(...);
    subplot(2,1,2), imshow(...);
      % or do we want to savefigs instead?

    inliers_count = 0
    if inliers_count > max(inliers_scores)
        transformation_params = cat(1, transformation_params, x) % TODO: doublecheck dimension to concatenate
        inliers_set = cat(1, inliers_set, inliers_count) % TODO: idem
    else

    end 