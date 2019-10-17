close all
%% parameter setting
n_clusters = 400; 
opt_rgb = 'rgb'; 
opt_dense = 'dense';

% These are the classes (airplanes, birds, ships, horses and cars)
% respectively
classes = [1, 2, 9, 7, 3];

n_images_train = 100; % number of images to load for training
n_images_test = 50; % number of images to load for testing
subset_ratio = 0.4; % max half of all training images

%% Fetch training data and split it in a subset for learning
% load the data
data_train = loadData('train', n_images, classes);
data_test = loadData('test', n_images, classes);

% Split the labels and the images and split the data for the vocab building
[vocab, x_train, y_train] = splitData(data_train, n_images_train, subset_ratio, classes);
[~, x_test, y_test] = splitData(data_test, n_images, 0, classes);

% Show that it works and that we're awesome
% figure; 
% imshow(x_train(:,:,:,15));

%% Extract features (Step 2.1 of assignment) 
feature_descriptor_matrix = extractFeatures(vocab, opt_rgb, opt_dense); 

%% Build visual words vocabulary (Step 2.2 of assignment)
visual_dictionary = build_visual_vocab(feature_descriptor_matrix, n_clusters); % Later we probably want a loop for cluster sizes too

%% Encoding Features Using Visual Vocabulary Once & Representing images by frequencies of visual words(Step 2.3 & 2.4 of assignment)
x_train_hists = represent_by_histograms(x_train, visual_dictionary, opt_rgb, opt_dense, n_clusters);

x_test_hists = represent_by_histograms(x_test, visual_dictionary, opt_rgb, opt_dense, n_clusters);

%% Classification with a SVM (step 2.5)
model = svmtrain(double(y_train), x_train_hists, '-b 1 -q 1');
[predicted_label, accuracy, prob_estimates] = svmpredict(double(y_test), x_test_hists, model);

