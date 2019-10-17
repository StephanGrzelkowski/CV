function [vocab, x, y] = splitData(data, n_images, ratio, classes)

n_vocab = n_images * ratio; % number of images in the vocab
n_class_v = n_vocab / length(classes); % number of images per class in vocab
n_train = n_images - n_vocab; % number of images in training
n_class_t = n_train / length(classes); % number of images per class in train

if ratio > 0
    low_bound_v = 1;
    high_bound_v = n_class_v;
    low_bound_t = 1;
    high_bound_t = n_class_t;
    vocab = nan(n_vocab, size(data,2));
    train = nan(n_train, size(data,2));
    for i = classes
        % Find the starting index of the class
        class_idx_first = find(data(:,1) == i, 1, 'first');
        class_idx_last = find(data(:,1) == i, 1, 'last');
        
        % Find the index of the following class
        subset_index = class_idx_first + n_class_v; 
        
        % Select the subset
        vocab_subset = data(class_idx_first:subset_index-1,:);
        train_subset = data(subset_index:class_idx_last,:);

        % Add subsets to the appropriate matrix
        vocab(low_bound_v:high_bound_v, :) = vocab_subset;
        train(low_bound_t:high_bound_t,:) = train_subset;
        low_bound_v = high_bound_v + 1;
        high_bound_v = high_bound_v + n_class_v;
        low_bound_t = high_bound_t + 1;
        high_bound_t = high_bound_t + n_class_t;
    end
    % Remove the class labels from the vocab
    vocab = vocab(:, 2:end); 
else
    vocab = [];
    train = data;
end

% Remove the class labels from the training data
x_vec = train(:, 2:end);
y = train(:, 1);

N = size(train,1);
% Reshape the images into the right sizes
x = nan(96,96,3,N); 
for it = 1 : N
    x(:,:,:,it) = reshape(squeeze(x_vec(it, :)), 96, 96, 3);
end

% Normalize the images
x = x./255;

end
