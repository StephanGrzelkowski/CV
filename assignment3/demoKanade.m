%% demoKanade
% this script runs the lucas kanade example for exercise 2
frame1 = double(imread('synth1.pgm'));
frame2 = double(imread('synth2.pgm'));
frame1 = double(rgb2gray(imread('sphere1.ppm')));
frame2 = double(rgb2gray(imread('sphere2.ppm')));

%size of the flow blocks
block_size = 15;

%run flow 
[mat_flow_vectors, X, Y] = lucas_kanade(frame1, frame2, block_size);

%visualize results
figure;
imshow(frame1./255)
hold on
%after centering the x and y in the center of the rectangles plot the
%quiver
center_offset = floor(block_size / 2) - 1;
quiver(reshape(X,[],1)+center_offset,reshape(Y,[],1)+center_offset,mat_flow_vectors(:,1),mat_flow_vectors(:,2))