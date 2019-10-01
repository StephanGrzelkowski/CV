function [BLOCKS, X, Y] = divide_img(im,block_size)
% An inputted image (frame) is divided into non-overlapping regions of nxn size, with n given by the block_size argument.
% The output is an nxnxm matrix. m is the m-th non-overlapping region.

s = size(im);

%find the needed padding
remx =  block_size - mod(s(2),block_size);
remy =  block_size - mod(s(1),block_size);

%pad the image
newIm = padarray(im,[remy,remx], 'post');
newS = size(newIm);
n_blocks = (newS(1) / block_size) * (newS(2) / block_size);

%prepare the grid
vec_grid_y = 1 : block_size : newS(1);
vec_grid_x = 1 : block_size : newS(2);
[X,Y] = meshgrid(vec_grid_x, vec_grid_y);

%assign the blocks
BLOCKS = zeros([block_size,block_size,n_blocks]);
for i = 1 : n_blocks 
    %get the block coordinates
    startx = X(i);
    endx = startx + block_size - 1;
    starty = Y(i);
    endy = starty + block_size - 1;
    
    %get the img data in the block
    block = newIm(starty   : endy, startx:endx);
    BLOCKS(:,:,i) = block;
    
end
end