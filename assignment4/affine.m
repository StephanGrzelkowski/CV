function transform_img = affine(img, transformation_matrix)
% This is our own implementation of performing an affine transformation on
% img, using parameters from the given transformation matrix. The
% transformed image is returned.

% Extract parameters
    m = transformation_matrix(1:2,1:2);
    t = transformation_matrix(3, 1:2);
    
% Define size variables    
    [N,M] = size(img);
    [W, H, min_w, min_h] = size_transformed_image(N, M, m, t);

% Initialize an 'empty image' of size W x H, the size of the new,
% transformed image.
    transform_img = zeros(H, W);
    
% Transform each pixel's original coordinate tuple to a new coordinate
% tuple, and put the pixel's intensity value into the right place of the initialized empty image using the new coordinates. 
    for i = 1:N
        for j = 1:M
            new_coords = round(m * [i;j] + t');
            a = new_coords(1) + min_h;
            b = new_coords(2) + min_w;
            transform_img(a, b) = img(i, j);
        end
    end
end