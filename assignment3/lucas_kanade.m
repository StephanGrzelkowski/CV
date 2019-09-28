%frame1 = imread('synth1.pgm');
%frame1 = imread('synth2.pgm');
frame1 = imread('sphere1.ppm');
frame2 = imread('sphere2.ppm');
lucaskanade(frame1, frame2, 15);

function [optical_flow] = lucaskanade(frame1, frame2, block_size)  

frame1 = rgb2gray(frame1);
frame2 = rgb2gray(frame2);

% Compute partial derivatives (with simple derivative filters, smoothing is
% not needed given the clean frames provided to us in this assignment)
Ix = imfilter(frame1, [-1 1; -1 1], 'same'); 
Iy = imfilter(frame1, [-1 -1; 1 1], 'same');

% Compute the difference in intensity between a frame and previous frame
It = frame2 - frame1;

% Divide maps of Intensity derivatives and It into non-overlapping regions
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
    b = double(b); % Otherwise it throws errors 
    v = pinv(double(A))* b' % Transpose the b vector, then compute the optical flow vector for this region

    % TO-DO (for Stephan): store all these v's into an array or sth to make it easy to
    % plot with quiver
end

end



