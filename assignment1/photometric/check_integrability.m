function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros([size(normals, 1), size(normals,2)]);
q = zeros([size(normals, 1), size(normals,2)]);
SE = zeros([size(normals, 1), size(normals,2)]);

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

% p and q can be quickly computed taking the point quotient of the
% respective 1st and 2nd element by the 3rd element of the normal 
p = normals(:,:,1) ./ normals(:,:,3); 
q = normals(:,:,2) ./ normals(:,:,3);

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

% loop over all pixels
for it_y = 1 : size(normals,1)
    for it_x = 1 : size(normals,2)
        if (it_x < size(normals,2)) && (it_y < size(normals,1))
            % get the differential in p over the x direction:
            change_p = p(it_y + 1, it_x) - p(it_y, it_x); 

            % the differential in q in the y direction:
            change_q = q(it_y, it_x + 1) - p(it_y, it_x); 

            %the squared error between the 2nd differentials:
            SE(it_y, it_x) = (change_p - change_q) ^ 2;
        end
    end
end

% ========================================================================




end

