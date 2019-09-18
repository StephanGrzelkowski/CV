close all
clear all
clc

disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './SphereGray5/';   % TODO: get the path of the script
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

disp('Fit done')

%show the albedo
figure; imshow(albedo)

%optionally save the figure
path_save = '/home/stephan/Documents/MATLAB/CV/assignment1/images/photometric/';
str_figure_save = '1_1a_estimation_albedo_5_shadow';
%print(print([path_save, str_figure_save], '-dpng'))
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.8;
SE(SE <= threshold) = NaN; % for good visualization

n_outliers= sum(SE > threshold, 'all');
fprintf('Number of outlierss: %d\n\n', n_outliers);

%show the standard error
figure;
imshow(SE)
title(sprintf('Number of outlier: %d ; with threshold: %d', n_outliers, threshold))
%some presets for saving
path_save = '/home/stephan/Documents/MATLAB/CV/assignment1/images/photometric/';
str_figure_save = '1_2_SE_25_8';
%print(print([path_save, str_figure_save], '-dpng'))

%% compute the surface height
height_map_c = construct_surface( p, q, 'column');
height_map_r = construct_surface( p, q, 'row');
height_map_avg = construct_surface(p, q, 'average');

%plot and save the surfaces
show_model(albedo, height_map_c)
print(join([path_save, '1_3_column_surface_', string(n)], ''), '-dpng')
show_model(albedo, height_map_r)
print(join([path_save, '1_3_row_surface_', string(n)], ''), '-dpng')
show_model(albedo, height_map_avg)
print(join([path_save, '1_3_avg_surface_', string(n)], ''), '-dpng')


%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map_avg);

%% Do the monkey
n_sample = [];
%load the images
image_dir = './MonkeyGray/';

[image_stack, scriptV] = load_syn_images(image_dir);


if ~isempty(n_sample)
    image_stack = image_stack(:,:,1 : n_sample);
    scriptV = scriptV(1 : n_sample, :);
end
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

disp('Fit done')

%show the albedo
figure; imshow(albedo)

%get p and q and SE
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization

n_outliers= sum(SE > threshold, 'all');
fprintf('Number of outlierss: %d\n\n', n_outliers);

%show the standard error
figure;
imshow(SE)
title(sprintf('Number of outlier: %d ; with threshold: %d', n_outliers, threshold))
%some presets for saving
path_save = '/home/stephan/Documents/MATLAB/CV/assignment1/images/photometric/';
str_figure_save = join([path_save, '1_4_monkeySE', string(n)], '');

%print( str_figure_save, '-dpng')

%reconstruct the surface
height_map_avg = construct_surface(p, q, 'average');
show_model(albedo, height_map_avg);

%% different color channels
image_dir = './MonkeyColor/';
%get naming convention
cell_channel_list = {'R'; 'G'; 'B'};

%loop through all channels
for it_channel = 1 : 3
    
    [image_stack, scriptV] = load_syn_images(image_dir, it_channel);
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);
    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);
    
    disp('Fit done')
    
    %show the albedo
    figure; imshow(albedo)
    
    %get p and q and SE
    disp('Integrability checking')
    [p, q, SE] = check_integrability(normals);
    
    threshold = 0.005;
    SE(SE <= threshold) = NaN; % for good visualization
    
    n_outliers= sum(SE > threshold, 'all');
    fprintf('Number of outlierss: %d\n\n', n_outliers);
    
    %show the standard error
    figure;
    imshow(SE)
    title(sprintf('Number of outlier: %d ; with threshold: %d', n_outliers, threshold))
    %some presets for saving
    path_save = '/home/stephan/Documents/MATLAB/CV/assignment1/images/photometric/';
    str_figure_save = join([path_save, '1_4_monkeySE', string(n)], '');
    
    %print( str_figure_save, '-dpng')
    
    %reconstruct the surface
    height_map_avg = construct_surface(p, q, 'average');
    show_model(albedo, height_map_avg);
    show_results(albedo, normals, SE)
end

%% Face
%load in the face data 
[image_stack, scriptV] = load_face_images('./yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.8;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height

%construct the height map using different methods 
height_map_col = construct_surface( p, q, 'column' );
height_map_row= construct_surface( p, q, 'row' );
height_map_avg = construct_surface( p, q, 'average' );

%show the SE and the height maps 
show_results(albedo, normals, SE);
show_model(albedo, height_map_col);
title('Column major')
show_model(albedo, height_map_row);
title('Row Major')
show_model(albedo, height_map_avg);
title('Column-Row Average')