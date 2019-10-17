function subset = loadData(type, N, classes)
% Function to load data | input: 'training' or 'test' | N is size of data
% (max 2500 for train, max 4000 for test)
data = load(['./stl10_matlab/' , type , '.mat']);

% Filter out the classes
indexes = ismember(data.y, classes);
used_data = [data.y(indexes), data.X(indexes, :)];

% All classes need to be equally represented in the training data
N_per_class = N / length(classes);
subset = nan(N, size(used_data, 2));
low_bound = 1;
high_bound = N_per_class;
for i = classes
    
    % Select all images from a certain class
    class_data = used_data(used_data(:,1) == i, :);
    
    % Shuffle the data and take the a subset
    idx = randperm(size(class_data,1));
    class_rdn = class_data(idx,:);
    class_subset = class_rdn(1:N_per_class, :);
    
    % Add the class data to the subset
    subset(low_bound:high_bound, :) = class_subset;
    low_bound = high_bound + 1;
    high_bound = high_bound + N_per_class; 
end
end