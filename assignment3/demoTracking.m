% This script runs the demo of the optical flow video creation 
%% toy person images

%data folder
str_folder = 'person_toy/';
%threshold for the harris detecor
threshold = 10;
%the scaling of the flow vector update
flow_scale = 1.5;
%grid size for flow calculations
block_size = 5;

tracking(str_folder, threshold, flow_scale, block_size)

%% pingpong images

%data folder
str_folder = 'pingpong/';
%threshold for the harris detecor
threshold = 10;
%the scaling of the flow vector update
flow_scale = 3;
%grid size for flow calculations
block_size = 15;

tracking(str_folder, threshold, flow_scale, block_size)
