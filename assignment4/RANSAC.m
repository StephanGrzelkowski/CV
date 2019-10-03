function [ best_transformation ] = RANSAC(matching_points, N, P, im1, im2) % TODO: check that this is the right output and input
% N = number of iterations
% P = nr of matches to randomly select from the total set of matching
% points
inliers_scores = []
transformation_params = []
inliers_set = []
for iteration = 1:N 
    rand_subset_matches = randperm(size(matching_points, 2), P));
    columns = matching_points(:, rand_subset_matches);
    A = ...
    b = .....
    x = pinv(A)*b;  % compute x, the transformation params
    
    transformed_im1 = copy(im) * x; % transform im1
    
    % Plot sth, but not sure yet what. TODO: find out
    subplot(2,1,1), imshow(...);
    subplot(2,1,2), imshow(...);
      % or do we want to savefigs instead?

    inliers_count = .....
    if inliers_count > max(inliers_scores)
        transformation_params = cat(1, transformation_params, x) % TODO: doublecheck dimension to concatenate
        inliers_set = cat(1, inliers_set, inliers_count) % TODO: idem
    else
        
         



    