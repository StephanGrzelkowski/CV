function [ best_transformation,best_matches ] = RANSAC(matches, f1, f2, N, P, img_stitched)
    % N = number of iterations
    % P = nr of matches to randomly select from the total set of matching points
    
    best_inliers = 0;
    best_transformation = [];
    best_matches= [];
    for iteration = 1:N
        

        % Shuffle matches and select the first P
        shuf_match = matches(:, randperm(size(matches,2)));
        subset = shuf_match(:, (1:P));

        xy_subset = f1((1:2), subset(1,:));
        xyp_subset = f2((1:2), subset(2,:));

        A = zeros(2*P, 6);
        b = zeros(2*P, 1);

        for i = 1:P
            a = [xy_subset(1, i) xy_subset(2, i) 0 0 1 0; 0 0 xy_subset(1, i) xy_subset(2, i) 0 1];
            A((2*i-1: 2*i), :) = a;
            b = [xyp_subset(1, i); xyp_subset(2, i)];
            B((2*i-1: 2*i), :) = b;
        end

        params = pinv(A)*B;
        m = reshape(params(1:4,:),[2,2])';
        t = params(5:end);

        xy_f1 = f1((1:2), matches(1,:));
        XY_f1 = zeros(2*size(matches,2), 6);
        for i = 1:size(matches, 2)
            XY_f1((2*i-1: 2*i), :) = [xy_f1(1, i) xy_f1(2, i) 0 0 1 0; 0 0 xy_f1(1, i) xy_f1(2, i) 0 1];
        end
        
        % Calculate the transformation
        XYP = XY_f1 * params;
        XYP = reshape(XYP, [2, size(matches,2)]);
        
        % Calculate distance
        xy_f2 = f2((1:2), matches(2,:));
        distances = vecnorm(xy_f2 - XYP,2);

        % Calculate inliers
        [row,col] = find(distances < 10);
        inliers = length(row);
        if inliers >= best_inliers
            best_inliers = inliers;
            best_transformation = [m(1,1) m(1,2) t(1); m(2,1) m(2,2) t(2); 0,0 1];
            best_matches = subset
        end

    end
%     % plot the image
%     XYP(1,:) = XYP(1, :) + size(img_stitched, 2)/2;
%     figure;
%     imshow(img_stitched./255);
%     hold on
%     scatter(xy_f1(1, 1:10), xy_f1(2,1:10), 'g', 'LineWidth', 2)
%     scatter(XYP(1, 1:10), XYP(2,1:10), 'r', 'LineWidth', 2)
%     for it = 1 : 10
%     line([xy_f1(1, it), XYP(1, it)], [xy_f1(2,it), XYP(2,it)], 'LineWidth', 1)
%     end

end