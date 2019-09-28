%im1 = imread('synth1.pgm');
%im1 = imread('synth2.pgm');
im1 = imread('sphere1.ppm');
im2 = imread('sphere2.ppm');
lucaskanade(im1, im2, 15);

function [optical_flow] = lucaskanade(im1, im2, block_size)  % rename to frame

% Compute partial derivatives (with a Sobel kernel: combining
% differentation with smoothing)
sobel_x = [1 2 1; 0 0 0; -1 -2 -1];
sobel_y = sobel_x';
Ix = imfilter(im1, sobel_x, 'same'); 
Iy = imfilter(im1, sobel_y, 'same');

% Compute the gradient of difference in intensity between one frame and previous frame
simple_derivative_filter = [1 -1]   % Not sure about this filter
temp = imfilter(im2-im1, simple_derivative_filter, 'replicate')
It = imfilter(temp, simple_derivative_filter', 'replicate')

% Divide frames into non-overlapping regions
Ix_blocks = divide_img(Ix, block_size);
Iy_blocks = divide_img(Iy, block_size);  
It_blocks = divide_img(It, block_size);
nr_of_regions = size(Ix_blocks, 3);

% For each region, compute A, transpose(A), b (see assignment)
%A = zeros(block_size * block_size, 2); % Might not need this
%b = zeros(block_size * block_size, 1); % ! Hey, might not need to initialize in Matlab
for region = 1:nr_of_regions;
    for row = 1:block_size;
        for col = 1:block_size;   
            A(row, 1) = Ix_blocks(row, col, region); % BOOKMARK when does the im2_blocks come in if at all?
            A(row, 2) = Iy_blocks(row, col, region);
            b(row) = -It_blocks(row, col, region);
        end
    end
    A_transpose = A';
    A
    size(A)
    v = inv(A_transpose * A) * A_transpose * b
end


end



