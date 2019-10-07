function [ best_transformation ] = RANSAC(matches, f1, f2, N, P)

% N = number of iterations
% P = nr of matches to randomly select from the total set of matching points
for iteration = 1:N
    best_inliers = 0;
    best_transformation = [];
    
    % Shuffle matches and select the first P
    shuf_match = matches(:, randperm(size(matches,2)));
    subset = shuf_match(:, (1:P));
       
    xy = f1((1:2), subset(1,:));
    xy_primes = f2((1:2), subset(2,:));
    
    for i = 1:P
        % Calculate the parameters
        A = [xy(1, i) xy(2, i) 0 0 1 0; 0 0 xy(1, i) xy(2, i) 0 1];
        b = [xy_primes(1, i); xy_primes(2, i)];
        params = pinv(A) * b;
        m = reshape(params(1:4,:),[2,2])';
        t = params(5:end);
        
        % Calculate the transformation based on the parameters
        all_xy = f1((1:2), matches(1,:));
        transform_xy = m * all_xy + t;
        true_xy_prime = f2((1:2), matches(2,:));
        
        % Calculate distance
        distances = vecnorm(transform_xy - true_xy_prime,2);
        [row,col] = find(distances < 10);
        
        % Calculate inliers
        inliers = length(row);
        if inliers > best_inliers
            best_inliers = inliers;
            best_transformation = [m, t; [0 0 1]];
        end
    end
end

end