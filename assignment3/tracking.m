%% feature tracking using harris corner detection and optical flow
%data folder
str_folder = 'person_toy/';


%find all frames
struc_dir = dir([str_folder, '/0*']);

%load the first frame
str_first_frame = struc_dir(1).name;
frame1 = double(imread([ str_folder, str_first_frame]))./255;


%threshold for the harris detecor
threshold = 10;
%the scaling of the flow vector update
flow_scale = 2;
%grid size for flow calculations
block_size = 20;

%do harris corner detection
[H, r, c] = harris_corner_detector(frame1, 5,1, threshold);

%start with first frame
frame1 = rgb2gray(frame1);
prev_frame = frame1;

%create video file
v = VideoWriter([str_folder, 'motion.avi']);
open(v)
figure;
imshow(frame1)
v_frame = getframe(gcf);
writeVideo(v, v_frame)
for fr = 2 : length(struc_dir) %skip the already written frame
    try
        %load the next frame
        cur_frame = double(rgb2gray(imread([ str_folder, struc_dir(fr).name])))./255;
        %calculate the flow vector
        [mat_flow, X, Y] = lucas_kanade(prev_frame, cur_frame, block_size);
        %find the correct quadrant for each corner point
        mapped_x = floor(c ./ block_size);
        mapped_y = floor(r ./ block_size);
        %find the block index
        idx_quadrant = mapped_x .* size(Y,1) + mapped_y - 1;
        %update the row and columns
        flow_update_r = mat_flow(idx_quadrant, 2);
        flow_update_c = mat_flow(idx_quadrant, 1);
        
        %plot the feature points and their flow vectors
        imshow(cur_frame)
        hold on
        quiver(c,r,flow_update_c, flow_update_r) %might need to switch c and r
        hold off
        % write the frame to video file
        v_frame = getframe(gcf);
        writeVideo(v, v_frame)
        %calculate new rows and columns of the features
        r = round(r + flow_update_r .* flow_scale);
        c = round(c + flow_update_c .* flow_scale);
        
        
    catch
        sprintf('Problem with frame %i',fr)
    end
end
close(v)