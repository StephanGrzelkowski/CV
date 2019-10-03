function [ best_transformation ] = RANSAC(matches, f1, f2, N, P, im1, im2) % TODO: check that this is the right output and input
% N = number of iterations
% P = nr of matches to randomly select from the total set of matching points

% Might not needs these lists, lets see
inliers_scores = [];
transformation_params = [];
inliers_set = [];

for iteration = 1:N  
    random_subset = randperm(size(matches, 2), P); % indices of subset of matches
    columns = matches(:, random_subset); % actual subset of matches
    xa_all = f1(1, columns(1,:));
    xb_all = f2(1, columns(2,:));
    ya_all = f1(2, columns(1,:));
    yb_all = f2(2,  columns(2,:));
    
    for i = 1:P
        A = [xa_all(i) ya_all(i) 0 0 1 0; 0 0 xa_all(i) ya_all(i) 0 1];
        b = [xb_all(i); yb_all(i)];
        x = pinv(A)*b;  % compute x, the transformation params
    end
    
    x_transposed = x';
    ms = reshape(x_transposed(1:4), [2,2]);
    ts = x(5:end);
      
    transformed_matchingpoints_img1 = ms * [matches(1,:); matches(2,:)] + ts;
    
    % TODO: plot as instructed (With lines from transformed points to im2)
%     subplot(3,1,1), imshow(im1);
%     subplot(3,1,2), imshow(transformed_matchingpoints_img1);
%     subplot(3,1,3), imshow(im2);
    % Maybe only plot/save that image in 1st iteration? We still need to do
    % more iterations and find the best params! Oddly structured assignment
     
    %TODO: think about how to calculate inliers when I'm more awake
    inliers_count = 0;
    if inliers_count > max(inliers_scores)
        transformation_params = cat(1, transformation_params, x); % TODO: doublecheck dimension to concatenate
        inliers_set = cat(1, inliers_set, inliers_count); % TODO: idem
    end
    % TODO: Add some line that returns the best transformation after N iterations
end