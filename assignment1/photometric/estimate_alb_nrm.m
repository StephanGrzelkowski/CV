function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
for it_h = 1 : h
   for it_w = 1 : w
       
%   stack image values into a vector i
        i = squeeze(image_stack(it_h, it_w, :)); 
        
%   construct the diagonal matrix scriptI
        %check if we want to apply the shadow trick
        if shadow_trick
            scriptI = diag(i);
            Ii = scriptI * i; 
            IV = scriptI * scriptV;
            
            %   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
            g = linsolve(IV, Ii);
        else 
            % if we don't want to apply the shadow trick we can skip the
            % step where we create the diagonal matrix I
            g = linsolve(scriptV, i); 
        end
%   albedo at this point is |g|
        albedo(it_h, it_w, 1) = norm(g);
%   normal at this point is g / |g|
        normal(it_h, it_w, :) = g ./ norm(g);
   end
end
% =========================================================================

end

