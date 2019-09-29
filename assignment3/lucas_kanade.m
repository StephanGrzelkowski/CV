% frame1 = double(imread('synth1.pgm'));
% frame2 = double(imread('synth2.pgm'));
frame1 = double(rgb2gray(imread('sphere1.ppm')));
frame2 = double(rgb2gray(imread('sphere2.ppm')));
lucaskanade(frame1, frame2, 15);

function [mat_flow_vectors] = lucaskanade(frame1, frame2, block_size)  

% Compute partial derivatives (with simple derivative filters, smoothing is
% not needed given the clean frames provided to us in this assignment)
Ix = imfilter(frame1, [-1 1], 'same'); 
Iy = imfilter(frame1, [-1;1], 'same');

% Compute the difference in intensity between a frame and previous frame
It = frame2 - frame1;

% Divide maps of Intensity derivatives and It into non-overlapping regions
[Ix_blocks, X, Y] = divide_img(Ix, block_size);
Iy_blocks = divide_img(Iy, block_size);  
It_blocks = divide_img(It, block_size);
nr_of_regions = size(Ix_blocks, 3);

% For each region, compute A, transpose(A), b (see assignment)
mat_flow_vectors = nan(nr_of_regions, 2);
for region = 1:nr_of_regions
    index = 1;
    b = nan(block_size^2, 1);
    A = nan(block_size^2, 2);
    
    for row = 1:block_size
        for col = 1:block_size   
            A(index, 1) = Ix_blocks(row, col, region); 
            A(index, 2) = Iy_blocks(row, col, region);
            b(index) = -It_blocks(row, col, region);
            index = index + 1;
        end
    end
    v = pinv(A' * A)*A'* b; % Transpose the b vector, then compute the optical flow vector for this region

    mat_flow_vectors(region, :) = v;
end
figure;
imshow(frame1./255)
hold on
%after centering the x and y in the center of the rectangles plot the
%quiver
quiver(reshape(X,[],1)+6,reshape(Y,[],1)+6,mat_flow_vectors(:,1),mat_flow_vectors(:,2))
end



