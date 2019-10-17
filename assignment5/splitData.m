function [vocab, x, y] = splitData(data, n_images, ratio, classes)
    n_class = n_images / length(classes) * ratio; %number of images per class
    
    vocab = [];
    train = [];
    for i = 1:length(classes)
        % find the starting index of the class
        class_idx = find(data(:,1) == classes(i), 1, 'first');
        if i+1 > length(classes)
            train_idx = size(data,1);
        else
            train_idx = find(data(:,1) == classes(i+1), 1, 'first')-1;
        end
        
        % Take the required number of images
        class_subset = data(class_idx:class_idx+n_class-1,:);
        train_subset = data(class_idx+n_class:train_idx, :);
        % Add subsets to the appropriate matrix
        vocab = vertcat(vocab, class_subset);
        train = vertcat(train, train_subset);
    end
    
% Split the labels from the data
vocab = vocab(:, 2:end); 
x_vec = train(:, 2:end);
y = train(:, 1);

N = size(train,1);
% Reshape the images into the right sizes
x = nan(96,96,3,N); 
for it = 1 : N
    x(:,:,:,it) = reshape(squeeze(x_vec(it, :)), 96, 96, 3);
end

%normalize
x = x./255;

test = 2;  
end
