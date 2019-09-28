%frame1 = imread('synth1.pgm');
%frame1 = imread('synth2.pgm');
frame1 = imread('sphere1.ppm');
frame2 = imread('sphere2.ppm');
lucaskanade(frame1, frame2, 15);

function [optical_flow] = lucaskanade(frame1, frame2, block_size)  

frame1 = rgb2gray(frame1);
frame2 = rgb2gray(frame2);

% Compute partial derivatives (with a Sobel kernel: combining
% differentation with smoothing)                     Hey wait, why, there's
% no noise in our images
sobel_x = [1 2 1; 0 0 0; -1 -2 -1];
sobel_y = sobel_x';
Ix = imfilter(frame1, sobel_x, 'same'); 
Iy = imfilter(frame1, sobel_y, 'same');

% Compute the differentiated difference in intensity between one frame and previous frame
simple_derivative_filter = [1 -1];   % Not sure about this filter
temp = imfilter(frame2-frame1, simple_derivative_filter, 'replicate');
It = imfilter(temp, simple_derivative_filter', 'replicate');

% Divide frames into non-overlapping regions
Ix_blocks = divide_img(Ix, block_size);
Iy_blocks = divide_img(Iy, block_size);  
It_blocks = divide_img(It, block_size);
nr_of_regions = size(Ix_blocks, 3);

% For each region, compute A, transpose(A), b (see assignment)
for region = 1:nr_of_regions;
    index = 1;
    for row = 1:block_size;
        for col = 1:block_size;   
            A(index, 1) = Ix_blocks(row, col, region); 
            A(index, 2) = Iy_blocks(row, col, region);
            b(index) = -It_blocks(row, col, region);
            index = index + 1;
        end
    end
    b = b'; % Turn it into a column vector 
    v = pinv(A) * b;
    
end


end



