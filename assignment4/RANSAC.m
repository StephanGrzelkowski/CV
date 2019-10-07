function [ best_transformation ] = RANSAC(matches, f1, f2, N, P, img1, img2) % TODO: check that this is the right output and input
% N = number of iterations
% P = nr of matches to randomly select from the total set of matching points

% Initialize some stuff we might need later 
inliers_scores = 0; 
inliers_indices = []; 
best_params = 0; 

% Calculating the transformation matrix x for N iterations, each iteration
% uses a different sample of the matches
for iteration = 1:N  
    rand_indices = randperm(size(matches, 2), P)'; % indices of subset of matches
    subset_matches = matches(:, rand_indices); % actual subset of matches
    x_f1 = f1(1, subset_matches(1,:));
    x_f2 = f2(1, subset_matches(2,:));
    y_f1 = f1(2, subset_matches(1,:));
    y_f2 = f2(2,  subset_matches(2,:));
    
    for i = 1:P
        A = [x_f1(i) y_f1(i) 0 0 1 0; 0 0 x_f1(i) y_f1(i) 0 1];
        b = [x_f2(i); y_f2(i)];
    end
    x = pinv(A)*b; % compute x, the transformation params, I believe it should be outside the small loop above
    x_transposed = x';
    m_params = reshape(x_transposed(1:4), [2,2]); % extract components of transformation matrix
    t_params = x(5:end);
       
    % Try transforming all T points in image 1 with the params found in this iteration
    f1_copy = f1;
    transf_T_im1 = m_params * [f1_copy(1, matches(1,:)); f1_copy(2, matches(1,:))] + t_params;
    
    
    %%% Now we will visualize how good these params are: plot lines between
    %%% the T points in image 1 (left) and the transformations thereof on
    %%% top of image 2 (right) 
    
    % Original coordinates of im1's T points
    xy_f1 = f1(1:2, matches(1, :));
    
    % add to the second image on the x so the position reflects the image in the
    transf_T_im1(1,:) = transf_T_im1(1, :) + size(img1, 2);

    stitched_img = [img1, img2];
    figure;
    imshow(stitched_img./255);
    hold on     
    scatter(xy_f1(1, rand_indices), xy_f1(2, rand_indices), 'g', 'LineWidth', 2)
    scatter(transf_T_im1(1, rand_indices), transf_T_im1(2, rand_indices), 'r', 'LineWidth', 2)
    for it = 1 : length(rand_indices)
        i = rand_indices(it)
        line([xy_f1(1, i), transf_T_im1(1, i)], [xy_f1(2,i), transf_T_im1(2,i)], 'LineWidth', 2)
    end

    %%%    We can also evaluate the quality of this iteration's transformation matrix by
    % calcuating nr. of inliers and comparing it with previous iteration. The params that give the largest nr of inliers are the best %%%
    f2_xy = f2(1:2, matches(2,:));
    inliers_count = 0;
    inliers_index = []; % initialize a list of indices of inlier points
    for point = 1:size(transf_T_im1, 2)
        distance = norm(f2_xy(:,point)-transf_T_im1(:,point)); % TODO: this is probably not the way
        if distance < 10;  
            inliers_count = inliers_count + 1;
            inliers_index = cat(2, inliers_index, point); % save the indices of the matching points that are inliers
        end
    end
    
    if inliers_count > max(inliers_scores)
        inliers_scores = cat(1, inliers_scores, inliers_count);
        %inliers_indices = cat(1, inliers_indices, inliers_index);
        %commenting this because otherwise it'll break, but also not ssure
        %why we're told to save inliers...
        best_params = x ;
    end
     
    % Transform image 1 with best_params (using a helper function
end