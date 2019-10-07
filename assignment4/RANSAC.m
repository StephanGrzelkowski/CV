function [ best_transformation ] = RANSAC(matches, f1, f2, N, P, img1, img2) % TODO: check that this is the right output and input
% N = number of iterations
% P = nr of matches to randomly select from the total set of matching points

inliers_scores = 0; 
inliers_indices = []; 
best_params = 0; 

% Calculating the transformation matrix x for N iterations, each iteration
% uses a different sample of the matches
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
      
    % Try transforming image 1 with the params found in this iteration
    transformed_matchingpoints_img1 = ms * [f1(1,matches(1,:)); f1(matches(2,:))] + ts;
    
    % Evaluate the quality of this iteration's transformation matrix by
    % calcuating nr. of inliers and comparing it with previous iterations'
    % transformation matrices
    xy_f2 = f2(1:2, matches(2,:));
    inliers_count = 0
    inliers_index = []; % initialize a list of indices of inlier points
    for point = 1:size(transformed_matchingpoints_img1, 2)
        distance = norm(xy_f2(:,point)-transformed_matchingpoints_img1(:,point)); % TODO: this is probably not the way
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
    
    
    % TODO: plot as instructed (bullet point between hint and instructions
    % about inliers)
    % Maybe only plot/save that image in 1st iteration? 
    
    % stitch the image columns for visualization;
%     img_stitched = [img1 , img2];
% 
%     %get the position of the feature points
%     xy_f1 = f1(1:2, matches(1, columns));
%     xy_f1_transformed = f1(1:2, matches(1, columns));
%     xy_f2 = f2(1:2, matches(2, columns)); 
% 
%     %add to the second image on the x so the position reflects the image in the
%     %stitching
%     xy_f2(1,:) = xy_f2(1, :) + size(img1, 2);
% 
%     %plot the images
%     figure;
%     imshow(img_stitched./255);
%     hold on
%     scatter(xy_f1(1, :), xy_f1(2,:), 'g', 'LineWidth', 2)
%     scatter(xy_f2(1, :), xy_f2(2,:), 'r', 'LineWidth', 2)
%     for it = 1 : size(xy_f1, 2)
%         line([xy_f1(1, it), xy_f2(1, it)], [xy_f1(2,it), xy_f2(2,it)], 'LineWidth', 2)
%     end

end