close all

%% Fetch training data and split it in a subset for learning the visual
% vocabulary and use the remainder for SVM training later
[x_dict, y_dict] = loadData('train', 2500);
x_dict = x_dict./255;
x_split_location = floor( size(x_dict, 4) / 2 );
x_subset_vocab_learning = x_dict(:, :, :, 1:x_split_location);
x_train = x_dict(:, :, :, x_split_location+1:end);

%% Show that that worked and that we're awesome
% figure; 
% imshow(x_dict(:,:,:,10)./255);

%% Extract features (Step 2.1 of assignment) 
feature_descriptor_matrix = extractFeatures(x_subset_vocab_learning, 'gray'); 

%% Build visual words vocabulary (Step 2.2 of assignment)
n_clusters = 40; 
visual_dictionary = build_visual_vocab(feature_descriptor_matrix, n_clusters); % Later we probably want a loop for cluster sizes too

%% Encoding Features Using Visual Vocabulary Once & Representing images by frequencies of visual words(Step 2.3 & 2.4 of assignment)
x_train_hists = represent_by_histograms(x_train, visual_dictionary, 'gray');






