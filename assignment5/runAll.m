close all
%% parameter setting
n_clusters = 400; 
opt_rgb = 'rgb'; 
opt_dense = 'dense';
%number of images to load for training
n_images_train = 100; 
ratio_dict = 2; 

%% Fetch training data and split it in a subset for learning

%load 
[x_dict, y_dict] = loadData('train', n_images_train);

%normalize
x_dict = x_dict./255;

%divide training samples for visual vocabulary and SVM 
x_split_location = floor( size(x_dict, 4) / ratio_dict);
x_subset_vocab_learning = x_dict(:, :, :, 1:x_split_location);
x_train = x_dict(:, :, :, x_split_location+1:end);

%% Show that that worked and that we're awesome
% figure; 
% imshow(x_dict(:,:,:,10)./255);

%% Extract features (Step 2.1 of assignment) 
feature_descriptor_matrix = extractFeatures(x_subset_vocab_learning, opt_rgb, opt_dense); 

%% Build visual words vocabulary (Step 2.2 of assignment)

visual_dictionary = build_visual_vocab(feature_descriptor_matrix, n_clusters); % Later we probably want a loop for cluster sizes too

%% Encoding Features Using Visual Vocabulary Once & Representing images by frequencies of visual words(Step 2.3 & 2.4 of assignment)
x_train_hists = represent_by_histograms(x_train, visual_dictionary, opt_rgb, opt_dense);






