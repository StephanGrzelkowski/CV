close all
%% parameter setting
n_clusters = 22; 
opt_rgb = 'rgb'; 
opt_opponent = 'oppo';
opt_dense = 'dense';

% These are the classes (airplanes, birds, ships, horses and cars)
% respectively
classes = [1, 2, 9, 7, 3];

%number of images to load for training
n_images = 100; 
ss_ratio = 0.2; %max half of all training images

%% Fetch training data and split it in a subset for learning
%load 
data = loadData('train', n_images, classes);

%divide training samples for visual vocabulary and SVM 
[x_vocab, x_train, y_train] = splitData(data, n_images, ss_ratio, classes);

% % Show that it works and that we're awesome
% figure; 
% imshow(x_train(:,:,:,8));

%% Extract features (Step 2.1 of assignment) 
 
feature_descriptor_matrix = extractFeatures(x_vocab, opt_rgb, opt_dense); 
 
%% Build visual words vocabulary (Step 2.2 of assignment)
visual_dictionary = build_visual_vocab(feature_descriptor_matrix, n_clusters); % Later we probably want a loop for cluster sizes too

%% Encoding Features Using Visual Vocabulary Once & Representing images by frequencies of visual words(Step 2.3 & 2.4 of assignment)
 
x_train_hists = represent_by_histograms(x_train, visual_dictionary, opt_rgb, opt_dense, n_clusters);
 
%% Classification with a SVM (step 2.5)
% uiteindelijk moeten we dit doen voor elke class
positive_examples = x_train_hists();




