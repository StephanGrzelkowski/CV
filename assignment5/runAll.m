close all

% Fetch training data
[x_dict, y_dict] = loadData('train', 100);

% Show that that worked and that we're awesome
figure; 
imshow(x_dict(:,:,:,10)./255);

% Extract features (Step 2.1 of assignment) 
feature_descriptor_matrix = extractFeatures(x_dict, 'gray'); % Later we probably want to create an array of gray, rgb, opponent and loop over it to extract different features
 
% Build visual words vocabulary (Step 2.2 of assignment)
clusters = build_visual_vocab(feature_descriptor_matrix, 3);



